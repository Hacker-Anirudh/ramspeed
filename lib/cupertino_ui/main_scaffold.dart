import 'package:flutter/cupertino.dart';
import 'package:ramspeed/cupertino_ui/dialogs.dart';
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
  final TextEditingController casController = TextEditingController(
    text: BodyStrings.casDecoration,
  );
  final TextEditingController mtController = TextEditingController(
    text: BodyStrings.speed,
  );
  final TextEditingController busController = TextEditingController(
    text: BodyStrings.busWidth,
  );
  final TextEditingController channelController = TextEditingController(
    text: BodyStrings.channels,
  );

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
      child: mainBody(context),
    );
  }

  CupertinoNavigationBar mainAppBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: const Text(Strings.appName),
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
        const SizedBox(height: 32),
        const Text(
          BodyStrings.dataEntry,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                controller: mtController,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                controller: busController,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
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
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                controller: casController,
              ),
            ),
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            CupertinoButton(
              child: const Text(BodyStrings.go),
              onPressed: () async {
                final String lStr;
                final String? spee;
                (lStr, spee) = await Logic.onGo(
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
            ),
            const Expanded(flex: 2, child: SizedBox()),
            CupertinoButton(
              onPressed: () async {
                await Dialogs.showHintsDialog(context);
              },
              child: const Icon(CupertinoIcons.info_circle),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              speed,
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
