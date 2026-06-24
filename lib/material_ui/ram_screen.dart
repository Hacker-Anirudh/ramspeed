import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final Future<void> Function() onShowHints;

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
      mainAxisSize: .min,
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
                keyboardType: TextInputType.number,
                controller: mtController,
                placeholder: BodyStrings.speed,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                controller: busController,
                placeholder: BodyStrings.busWidth,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
              child: const Text(BodyStrings.go),
              onPressed: () async {
                await onGo();
              },
            ),
            const Expanded(flex: 2, child: SizedBox()),
            CupertinoButton(
              onPressed: () async {
                await onShowHints();
              },
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

class RamScreen extends StatelessWidget {
  const RamScreen({
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
  final Future<void> Function() onShowHints;

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
      mainAxisSize: MainAxisSize.min,
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
                await onGo();
              },
            ),
            const Expanded(flex: 2, child: SizedBox()),
            ElevatedButton(
              onPressed: () async {
                await onShowHints();
              },
              child: const Icon(Icons.info_outline_rounded),
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
