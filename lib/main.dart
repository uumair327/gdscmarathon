import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marathon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MarathonScreen(),
    );
  }
}

class MarathonScreen extends StatefulWidget {
  const MarathonScreen({super.key});

  @override
  _MarathonScreenState createState() => _MarathonScreenState();
}

class _MarathonScreenState extends State<MarathonScreen> {
  int timerValue = 0; // You can replace this with the actual timer value
  int checkpoint = 0;
  String selectedDifficulty = 'easy'; // Default difficulty
  bool marathonStarted = false;

  String question = 'What is the capital of Flutterland?';
  List<String> options = ['Option A', 'Option B', 'Option C', 'Option D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marathon App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Timer:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '$timerValue',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Checkpoint:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '$checkpoint',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedDifficulty,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDifficulty = newValue!;
                });
              },
              items: <String>['easy', 'medium', 'hard'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                );
              }).toList(),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  marathonStarted = true;
                });
              },
              child: const Text(
                'Start Marathon',
                style: TextStyle(fontSize: 18),
              ),
            ),
            if (marathonStarted)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    question,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: options
                        .map(
                          (option) => ElevatedButton(
                            onPressed: () {
                              // Handle option selection logic
                            },
                            child: Text(option),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
