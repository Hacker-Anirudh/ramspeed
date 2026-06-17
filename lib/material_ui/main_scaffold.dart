import 'package:flutter/material.dart';
import 'package:ramspeed/material_ui/dialogs.dart';
import 'package:ramspeed/shared/logic.dart';
import 'package:ramspeed/shared/strings.dart';

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
  String speed = Strings.memeSpeed;
  double latency = 420;
  String latencyStr = '';

  @override
  void dispose() {
    casController.dispose();
    mtController.dispose();
    busController.dispose();
    channelController.dispose();
    super.dispose();
  }

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
        Strings.appName,
        style: TextStyle(fontFamily: 'VT323', fontSize: 32),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationIcon: Image.asset('assets/appicon.png'),
              applicationName: Strings.appName,
              applicationVersion: Strings.appVersion,
              applicationLegalese: Strings.legalese,
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
        child: mainColumn(context),
      ),
    );
  }

  Column mainColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          BodyStrings.dataEntry,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: BodyStrings.speed,
                ),
                controller: mtController,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: BodyStrings.busWidth,
                ),
                controller: busController,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: BodyStrings.channels,
                ),
                controller: channelController,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          BodyStrings.cas,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: BodyStrings.casDecoration,
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
              child: const Text(BodyStrings.go),
              onPressed: () async {
                final result = Math.toRAMSpeed(
                  mtController.text,
                  busController.text,
                  channelController.text,
                );
                if (result == null) {
                  await Dialogs.showErrorDialog(
                    context,
                    BodyStrings.invalidInput,
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
    );
  }
}
