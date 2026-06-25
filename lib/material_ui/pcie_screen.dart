import 'package:flutter/material.dart';
import 'package:ramspeed/shared/logic.dart';
import 'package:ramspeed/shared/strings.dart';

class PCIeScreen extends StatefulWidget {
  const PCIeScreen({required this.isBinaryPrefix, super.key});

  final bool isBinaryPrefix;

  @override
  State<PCIeScreen> createState() => _PCIeScreenState();
}

class _PCIeScreenState extends State<PCIeScreen> {
  final List<int> _gens = [1, 2, 3, 4, 5, 6, 7];
  final List<int> _lanes = [1, 2, 4, 8, 12, 16, 32];

  int? _selectedGen;
  int? _selectedLanes;

  @override
  Widget build(BuildContext context) {
    final speed = PCIeSpeedLogic.toSpeedStr(
      _selectedGen,
      _selectedLanes,
      isBinaryPrefix: widget.isBinaryPrefix,
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(height: 8),
            const Text(
              PCIeStrings.gen,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              initialValue: _selectedGen,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text(PCIeStrings.selGen),
              items: _gens
                  .map((g) => DropdownMenuItem(value: g, child: Text('Gen $g')))
                  .toList(),
              onChanged: (v) => setState(() => _selectedGen = v),
            ),
            const SizedBox(height: 16),
            const Text(
              PCIeStrings.lanes,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              initialValue: _selectedLanes,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text(PCIeStrings.selLanes),
              items: _lanes
                  .map(
                    (l) => DropdownMenuItem(value: l, child: Text('x$l')),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _selectedLanes = v),
            ),
            const SizedBox(height: 24),
            const Text(
              PCIeStrings.computedSpeed,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              speed.isEmpty ? '-' : speed,
              style: const TextStyle(fontFamily: 'VT323', fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}
