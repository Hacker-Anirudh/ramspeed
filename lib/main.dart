import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RAMSpeed',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RAMSpeed'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter the following data:",
                      style: TextStyle(fontSize: 24),
                    ),
                    Row(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: "Speed in MT/s",
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: "Bus width",
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: "Number of channels",
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "To calculate the latency, enter the CL- rating (e.g. CL30)",
                    ),
                    Row(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: "CL rating",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
