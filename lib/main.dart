import 'package:flutter/material.dart';
import 'package:ramspeed/logic.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController casController = TextEditingController();
  final TextEditingController mtController = TextEditingController();
  final TextEditingController busController = TextEditingController();
  final TextEditingController channelController = TextEditingController();

  double cas = 0;
  double mt = 0;
  double bus = 0;
  double channels = 0;
  String speed = '';
  bool isDark = true;

  AlertDialog get alert => AlertDialog(
    title: Text("Error"),
    content: Text("Make sure your inputs are valid."),
    actions: [okButton],
  );

  Widget okButton = TextButton(child: Text("OK"), onPressed: () {});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RAMSpeed',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent,
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: Colors.blueAccent,
      ),

      home: mainScaffold(context),
    );
  }

  Scaffold mainScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RAMSpeed')),
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
                      controller: mtController,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Bus width"),
                      controller: busController,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Channels"),
                      controller: channelController,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              const Text(
                "To calculate the latency, enter the CAS latency (e.g. CL30):",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "CAS latency",
                      ),
                      controller: casController,
                    ),
                  ),
                  const Expanded(flex: 2, child: SizedBox()),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text("Go!"),
                onPressed: () {
                  try {
                    setState(() {
                      cas = double.parse(casController.text);
                      mt = double.parse(mtController.text);
                      bus = double.parse(busController.text);
                      channels = double.parse(channelController.text);
                      speed = Math.toRAMSpeed(mt, bus, channels);
                    });
                  } on FormatException {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                },
              ),
              SizedBox(height: 16),
              Text(speed),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Tooltip(
          message: 'Toggle light/dark mode',
          child: IconButton(
            isSelected: isDark,
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
            icon: const Icon(Icons.wb_sunny_outlined),
            selectedIcon: const Icon(Icons.brightness_2_outlined),
          ),
        ),
      ),
    );
  }
}
