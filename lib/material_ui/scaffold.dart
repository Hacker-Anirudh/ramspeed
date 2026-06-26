import 'package:flutter/material.dart';
import 'package:ramspeed/material_ui/dialogs.dart';
import 'package:ramspeed/material_ui/pcie_screen.dart';
import 'package:ramspeed/material_ui/ram_screen.dart';
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
  int _selectedIndex = 0;
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
  bool isBinaryPrefix = false;

  static const List<Widget> isBinary = <Widget>[
    Text('Binary'),
    Text('Decimal'),
  ];

  Future<void> _recomputeValues() async {
    final String lStr;
    final String? spee;
    (lStr, spee) = await RamSpeedLogic.onGo(
      mtController.text,
      busController.text,
      channelController.text,
      casController.text,
      isBinaryPrefix: isBinaryPrefix,
    );
    if (spee != null) {
      final nonNullSpeed = spee;
      setState(() {
        speed = nonNullSpeed;
        latencyStr = lStr;
      });
    }
  }

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
      persistentFooterButtons: [
        Center(
          child: ToggleButtons(
            borderRadius: const .all(Radius.circular(16)),
            isSelected: [isBinaryPrefix, !isBinaryPrefix],
            onPressed: (index) async {
              setState(() {
                isBinaryPrefix = index == 0;
              });
              await _recomputeValues();
            },
            children: isBinary,
          ),
        ),
      ],
      appBar: mainAppBar(context),
      body: Row(
        crossAxisAlignment: .start,
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.memory),
                label: Text('RAM'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.cable_rounded),
                label: Text('PCIe'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: _selectedIndex == 0
                ? RamScreen(
                    casController: casController,
                    mtController: mtController,
                    busController: busController,
                    channelController: channelController,
                    speed: speed,
                    latencyStr: latencyStr,
                    onGo: () async {
                      final String lStr;
                      final String? spee;
                      (lStr, spee) = await RamSpeedLogic.onGo(
                        mtController.text,
                        busController.text,
                        channelController.text,
                        casController.text,
                        isBinaryPrefix: isBinaryPrefix,
                      );
                      if (spee != null) {
                        final nonNullSpeed = spee;
                        setState(() {
                          speed = nonNullSpeed;
                          latencyStr = lStr;
                        });
                      } else {
                        if (!context.mounted) return;
                        await Dialogs.showErrorDialog(
                          context,
                          DialogStrings.invalidInput,
                        );
                      }
                    },
                    onShowHints: () async {
                      await Dialogs.showHintsDialog(context);
                    },
                  )
                : PCIeScreen(
                    isBinaryPrefix: isBinaryPrefix,
                  ),
          ),
        ],
      ),
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
}
