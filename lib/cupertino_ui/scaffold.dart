import 'package:flutter/cupertino.dart';
import 'package:ramspeed/cupertino_ui/dialogs.dart';
import 'package:ramspeed/cupertino_ui/pcie_screen.dart';
import 'package:ramspeed/cupertino_ui/ram_screen.dart';
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
    return CupertinoPageScaffold(
      navigationBar: mainAppBar(context),
      child: _selectedIndex == 0
          ? MainBody(
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
                );
                if (spee != null) {
                  setState(() {
                    // Nothing seems to please the thing, if I add a null check
                    // it complains (rightly) that there is already a check so
                    // it's unneeded
                    // ignore: cast_nullable_to_non_nullable
                    speed = spee as String;
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
          : const PCIeScreen(),
    );
  }

  CupertinoNavigationBar mainAppBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: CupertinoSlidingSegmentedControl<int>(
        groupValue: _selectedIndex,
        children: const {
          0: Padding(
            padding: .symmetric(horizontal: 8),
            child: Text('RAM'),
          ),
          1: Padding(
            padding: .symmetric(horizontal: 8),
            child: Text('PCIe'),
          ),
        },
        onValueChanged: (v) {
          if (v == null) return;
          setState(() {
            _selectedIndex = v;
          });
        },
      ),
      leading: CupertinoButton(
        onPressed: widget.onThemeToggle,
        child: Icon(
          widget.isDark ? CupertinoIcons.brightness : CupertinoIcons.sun_max,
        ),
      ),
      trailing: CupertinoButton(
        onPressed: () async {
          await Dialogs.showAboutDialog(context);
        },
        child: const Icon(CupertinoIcons.info),
      ),
    );
  }
}
