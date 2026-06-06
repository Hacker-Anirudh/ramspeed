import 'package:flutter/material.dart';
import 'package:ramspeed/logic.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({
    required this.isDark,
    required this.onThemeToggle,
    super.key,
  });
  final bool isDark;
  final VoidCallback onThemeToggle;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: mainBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onThemeToggle,
        child: Icon(
          widget.isDark ? Icons.brightness_2_outlined : Icons.wb_sunny_outlined,
        ),
      ),
    );
  }

  AppBar mainAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'RAMSpeed',
        style: TextStyle(fontFamily: 'VT323', fontSize: 32),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationIcon: Image.asset('assets/appicon.png'),
              applicationName: 'RAMspeed',
              applicationVersion: '1.2.5',
              applicationLegalese:
                  '(c) 2020-2026 Anirudh Menon. GNU GPL v3 license. All rights reserved.\nFor feature suggestions/bug reports, open an issue on Github.',
            );
          },
          icon: const Icon(Icons.info_rounded),
        ),
      ],
    );
  }

  SingleChildScrollView mainBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter the following data:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Speed (MT/s)',
                    ),
                    controller: mtController,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Bus width'),
                    controller: busController,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Channels'),
                    controller: channelController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'To calculate the latency, enter the CAS latency (e.g. CL30):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'CAS latency'),
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
                  child: const Text('Go!'),
                  onPressed: () async {
                    final result = Math.toRAMSpeed(
                      mtController.text,
                      busController.text,
                      channelController.text,
                    );
                    if (result == null) {
                      await Dialogs.showErrorDialog(
                        context,
                        'Make sure your inputs are valid.',
                      );
                    } else {
                      setState(() {
                        latencyStr = Math.toLatencyStr(
                          casController.text,
                          mtController.text,
                        );
                        speed = result;
                      });
                    }
                  },
                ),
                const Expanded(flex: 2, child: SizedBox()),
                ElevatedButton(
                  onPressed: () async {
                    await Dialogs.showHintsDialog(context);
                  },
                  child: const Icon(Icons.info_outline_rounded),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Speed: $speed',
                  style: const TextStyle(fontFamily: 'VT323', fontSize: 32),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  latencyStr,
                  style: const TextStyle(fontFamily: 'VT323', fontSize: 32),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
