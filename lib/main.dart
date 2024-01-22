import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

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
  final stopwatch = StopWatchTimer(onChange: (value) {
    final displayTime = StopWatchTimer.getDisplayTime(value);
  });

  int checkpoint = 0;
  String selectedDifficulty = 'easy'; // Default difficulty
  bool marathonStarted = false;

  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  String questionS = 'Marathon Start Question';
  String question1 = 'Checkpoint 1 Question';
  String question2 = 'Checkpoint 2 Question';

  List<String> options = ['Option A', 'Option B', 'Option C', 'Option D'];

  String _printDuration(Duration duration) {
    String milliseconds = (duration.inMilliseconds % 1000)
        .toString()
        .padLeft(2, "0"); // this one for the miliseconds
    String seconds = ((duration.inMilliseconds ~/ 1000) % 60)
        .toString()
        .padLeft(2, "0"); // this is for the second
    String minutes =
        ((duration.inMilliseconds ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    return "$minutes : $seconds : $milliseconds";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await stopwatch.dispose(); // Need to call dispose function.
  }

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
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          StreamBuilder<int>(
                            stream: stopwatch.rawTime,
                            initialData: stopwatch.rawTime.value,
                            builder: (context, snap) {
                              final value = snap.data!;
                              final displayTime =
                                  StopWatchTimer.getDisplayTime(value);
                              return Column(
                                children: <Widget>[
                                  Text(
                                    displayTime,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                    ),
                                  ),
                                ],
                              );
                            },
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
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
            if (!marathonStarted)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    marathonStarted = true;
                    stopwatch.onStartTimer();
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
                    questionS,
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
                                _qrBarCodeScannerDialogPlugin
                                    .getScannedQrBarCode(
                                  context: context,
                                  onCode: (scannedCode) {
                                    setState(() {
                                      this.code = scannedCode;
                                      switch (scannedCode) {
                                        case "GDSC: Check Point 1":
                                          checkpoint = 1;
                                          questionS = question1;
                                          break;
                                        case "GDSC: Check Point 2":
                                        checkpoint =2;
                                          questionS = question2;
                                        break;
                                      }
                                      // Update checkpoint logic
                                       }
                                    );
                                  },
                                );
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
