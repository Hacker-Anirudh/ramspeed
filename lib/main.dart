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
  bool isDark = true;

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
      ),
      home: Builder(
        builder: (context) => MainScaffold(
          isDark: isDark,
          onThemeToggle: () {
            setState(() {
              isDark = !isDark;
            });
          },
        ),
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;

  const MainScaffold({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final TextEditingController casController = TextEditingController();
  final TextEditingController mtController = TextEditingController();
  final TextEditingController busController = TextEditingController();
  final TextEditingController channelController = TextEditingController();

  double cas = 0;
  double mt = 0;
  double bus = 0;
  double channels = 0;
  String speed = '6967 YB/s';
  double latency = 420;
  String latencyStr = '';

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Make sure your inputs are valid."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
            ),
          ],
        );
      },
    );
  }

  void showHintsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        final cs = Theme.of(ctx).colorScheme;

        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: cs.primary),
                  const SizedBox(width: 12),
                  Text(
                    'How do I find this info?',
                    style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListTile(
                      horizontalTitleGap: 12,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.speed_rounded, color: cs.secondary),
                      title: const Text(
                        'MT/s (MegaTransfers per second)',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'Bus speed. Typically a prominent specification, sometimes also shown as, for example, DDR5-6400. This would mean 6400 MT/s.',
                      ),
                    ),
                    const Divider(height: 16),
                    ListTile(
                      horizontalTitleGap: 12,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.reorder_rounded, color: cs.secondary),
                      title: const Text(
                        'Bus Width',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'Typically 64-bit for PCs, 16-bit for smartphones and derivatives (for example Apple M-series silicon).',
                      ),
                    ),
                    const Divider(height: 16),
                    ListTile(
                      horizontalTitleGap: 12,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.input_rounded, color: cs.secondary),
                      title: const Text(
                        'Number of Channels',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'Can usually be found online. (Or on a PC, check hardware info software.)',
                      ),
                    ),
                    const Divider(height: 16),
                    ListTile(
                      horizontalTitleGap: 12,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.timer_outlined, color: cs.secondary),
                      title: const Text(
                        'CAS Latency',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'Also usually a prominent specification on PC RAM kits, but is almost never found in specs of other devices.',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Got it'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RAMSpeed',
          style: TextStyle(fontFamily: 'VT323', fontSize: 32.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter the following data:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              Row(
                children: [
                  ElevatedButton(
                    child: const Text("Go!"),
                    onPressed: () {
                      try {
                        setState(() {
                          mt = double.parse(mtController.text);
                          bus = double.parse(busController.text);
                          channels = double.parse(channelController.text);
                          speed = Math.toRAMSpeed(mt, bus, channels);
                        });
                      } on FormatException {
                        _showErrorDialog(context);
                        mt = 1; // This prevents a divide-by-zero error
                      }
                      try {
                        String castemp = casController.text;
                        castemp = castemp.replaceAll(RegExp(r'[^0-9]'), '');
                        cas = double.parse(castemp);
                        latency = cas * (2000 / mt);
                        latencyStr = 'Total latency: $latency ns';
                      } on FormatException {
                        cas = 0;
                        latency = 0;
                        'Total latency: $latency ns';
                      }
                    },
                  ),
                  Expanded(flex: 2, child: SizedBox()),
                  ElevatedButton(
                    onPressed: () {
                      showHintsDialog(context);
                    },
                    child: Icon(Icons.info_outline_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Speed: $speed",
                    style: TextStyle(fontFamily: 'VT323', fontSize: 32),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    latencyStr,
                    style: TextStyle(fontFamily: 'VT323', fontSize: 32),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onThemeToggle,
        child: Icon(
          widget.isDark ? Icons.brightness_2_outlined : Icons.wb_sunny_outlined,
        ),
      ),
    );
  }
}
