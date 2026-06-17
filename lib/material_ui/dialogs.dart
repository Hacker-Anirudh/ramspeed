import 'package:flutter/material.dart';
import 'package:ramspeed/shared/strings.dart';

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
                    DialogStrings.q,
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
                        DialogStrings.mt,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        DialogStrings.mtExplanation,
                      ),
                    ),
                    const Divider(height: 16),
                    ListTile(
                      horizontalTitleGap: 12,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.reorder_rounded, color: cs.secondary),
                      title: const Text(
                        DialogStrings.bus,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        DialogStrings.busExplanation,
                      ),
                    ),
                    const Divider(height: 16),
                    ListTile(
                      horizontalTitleGap: 12,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.input_rounded, color: cs.secondary),
                      title: const Text(
                        DialogStrings.channels,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        DialogStrings.channelsExplanation,
                      ),
                    ),
                    const Divider(height: 16),
                    ListTile(
                      horizontalTitleGap: 12,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.timer_outlined, color: cs.secondary),
                      title: const Text(
                        DialogStrings.cas,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        DialogStrings.casExplanation,
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
                  child: const Text(DialogStrings.gotit),
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
          title: const Text(DialogStrings.error),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text(DialogStrings.ok),
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
