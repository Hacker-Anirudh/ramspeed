import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _CAScontroller = TextEditingController();
  final TextEditingController _MTcontroller = TextEditingController();
  final TextEditingController _buscontroller = TextEditingController();
  final TextEditingController _channelcontroller = TextEditingController();

  double? cas = 0;
  double? MT = 0;
  double? bus = 0;
  double? channels = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RAMSpeed',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RAMSpeed'),
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter the following data:",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Speed (MT/s)",
                        ),
                        controller: _MTcontroller,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Bus width",
                        ),
                        controller: _buscontroller,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Channels",
                        ),
                        controller: _channelcontroller,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                const Text(
                  "To calculate the latency, enter the CL rating (e.g., 30):",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "CL rating",
                        ),
                        controller: _CAScontroller,
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      cas = double.tryParse(_CAScontroller.text);
                      MT = double.tryParse(_MTcontroller.text);
                      bus = double.tryParse(_buscontroller.text);
                      channels = double.tryParse(_channelcontroller.text);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.info),
          onPressed: () {
            print('TBD');
          },
        ),
      ),
    );
  }
}
