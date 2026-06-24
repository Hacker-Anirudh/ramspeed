import 'package:flutter/cupertino.dart';
import 'package:ramspeed/shared/logic.dart';
import 'package:ramspeed/shared/strings.dart';

class PCIeScreen extends StatefulWidget {
  const PCIeScreen({super.key});

  @override
  State<PCIeScreen> createState() => _PCIeScreenState();
}

class _PCIeScreenState extends State<PCIeScreen> {
  final List<int> _gens = [1, 2, 3, 4, 5, 6, 7];
  final List<int> _lanes = [1, 2, 4, 8, 12, 16, 32];

  int? _selectedGen;
  int? _selectedLanes;

  Future<void> _showPicker(
    List<int> options,
    int initial,
    ValueChanged<int> onSelected,
  ) async {
    final initialIndex = options.indexOf(initial).clamp(0, options.length - 1);
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) {
        var tempValue = options[initialIndex];
        return Container(
          height: 300,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: .end,
                  children: [
                    CupertinoButton(
                      padding: const .symmetric(horizontal: 12),
                      child: const Text(PCIeStrings.done),
                      onPressed: () {
                        onSelected(tempValue);
                        Navigator.of(popupContext).pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 36,
                  scrollController: FixedExtentScrollController(
                    initialItem: initialIndex,
                  ),
                  onSelectedItemChanged: (i) => tempValue = options[i],
                  children: options
                      .map((o) => Center(child: Text(o.toString())))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _selector(
    String label,
    int? value,
    List<int> options,
    ValueChanged<int> onSelected,
  ) {
    final display = value == null ? PCIeStrings.sel : value.toString();
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            CupertinoButton.filled(
              padding: const .symmetric(horizontal: 16, vertical: 12),
              child: Text(display),
              onPressed: () => _showPicker(options, value ?? options[0], (v) {
                setState(() => onSelected(v));
              }),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final speed = PCIeSpeedLogic.toSpeedStr(_selectedGen, _selectedLanes);

    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const .all(16),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              const SizedBox(height: 8),
              _selector(
                PCIeStrings.gen,
                _selectedGen,
                _gens,
                (v) => _selectedGen = v,
              ),
              const SizedBox(height: 16),
              _selector(
                PCIeStrings.lanes,
                _selectedLanes,
                _lanes,
                (v) => _selectedLanes = v,
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
      ),
    );
  }
}
