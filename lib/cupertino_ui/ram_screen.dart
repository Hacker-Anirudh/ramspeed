import 'package:flutter/cupertino.dart';
import 'package:ramspeed/shared/strings.dart';

class MainBody extends StatelessWidget {
  const MainBody({
    required this.casController,
    required this.mtController,
    required this.busController,
    required this.channelController,
    required this.speed,
    required this.latencyStr,
    required this.onGo,
    required this.onShowHints,
    super.key,
  });

  final TextEditingController casController;
  final TextEditingController mtController;
  final TextEditingController busController;
  final TextEditingController channelController;
  final String speed;
  final String latencyStr;
  final Future<void> Function() onGo;
  final VoidCallback onShowHints;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const .all(24),
        child: _mainColumn(context),
      ),
    );
  }

  Column _mainColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
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
                keyboardType: .number,
                controller: mtController,
                placeholder: BodyStrings.speed,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CupertinoTextField(
                keyboardType: .number,
                controller: busController,
                placeholder: BodyStrings.busWidth,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CupertinoTextField(
                keyboardType: .number,
                controller: channelController,
                placeholder: BodyStrings.channels,
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
                keyboardType: .number,
                controller: casController,
                placeholder: BodyStrings.casDecoration,
              ),
            ),
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            CupertinoButton(
              onPressed: onGo,
              child: const Text(BodyStrings.go),
            ),
            const Expanded(flex: 2, child: SizedBox()),
            CupertinoButton(
              onPressed: onShowHints,
              child: const Icon(CupertinoIcons.info_circle),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: .center,
          children: [
            Text(
              speed,
              style: const TextStyle(fontFamily: 'VT323', fontSize: 32),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: .center,
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
