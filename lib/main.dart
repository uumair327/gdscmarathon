import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MarathonScreen({Key? key}) : super(key: key);

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
                Expanded(
                  child: Card(
                    color: Colors.blue, // Background color
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            'Timer:',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            '$timerValue',
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    color: Colors.blue, // Background color
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            'Checkpoint:',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            '$checkpoint',
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
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
                          (option) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue, // Background color
                                onPrimary: Colors.white, // Text color
                                padding: const EdgeInsets.all(16),
                              ),
                              onPressed: () {
                                // Handle option selection logic
                              },
                              child: Text(
                                option,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
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
