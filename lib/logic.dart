import 'package:flutter/material.dart';

class Math {
  static String? toRAMSpeed(
    String mt,
    String bus,
    String channels,
  ) {
    final mttemp = double.tryParse(mt);
    final bustemp = double.tryParse(bus);
    final channelstemp = double.tryParse(channels);
    if (mttemp == null || bustemp == null || channelstemp == null) return null;
    final tempval = (mttemp * bustemp * channelstemp) / 8;
    if (tempval < 1000) {
      return '$tempval MB/s';
    } else if (tempval < 1000000) {
      final rval = tempval / 1000;
      return '$rval GB/s';
    } else {
      final rval = tempval / 1000000;
      return '$rval TB/s';
    }
  }

  static String toLatencyStr(String casinput, String mtinput) {
    final castemp = casinput.replaceAll(RegExp('[^0-9]'), '');

    final mt = double.tryParse(mtinput);
    final cas = double.tryParse(castemp);

    if (mt == null || cas == null || mt <= 0) {
      return '';
    } else {
      final latency = cas * (2000 / mt);
      return 'Total latency: ${latency.toStringAsFixed(2)} ns';
    }
  }
}

class Dialogs {
  static Future<void> showHintsDialog(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
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
                        'Typically 64-bit for PCs, 16-bit for smartphones '
                        'and derivatives (for example Apple M-series silicon).',
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
                        'Can usually be found online. '
                        '(Or on a PC, check hardware info software.)',
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
                        'Also usually a prominent specification on PC RAM, '
                        'but is very rarely found in specs of other devices.',
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

  static Future<void> showErrorDialog(
    BuildContext context,
    String message,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
            ),
          ],
        );
      },
    );
  }
}
