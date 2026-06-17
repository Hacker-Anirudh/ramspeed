import 'package:flutter/cupertino.dart';
import 'package:ramspeed/shared/strings.dart';

class Dialogs {
  static Future<void> showHintsDialog(BuildContext context) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) {
        final theme = CupertinoTheme.of(ctx);

        return SafeArea(
          top: false,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.info, color: theme.primaryColor),
                      const SizedBox(width: 12),
                      const Text(
                        DialogStrings.q,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                        _hintRow(
                          ctx,
                          CupertinoIcons.speedometer,
                          DialogStrings.mt,
                          DialogStrings.mtExplanation,
                        ),
                        const SizedBox(height: 16),
                        _hintRow(
                          ctx,
                          CupertinoIcons.list_bullet,
                          DialogStrings.bus,
                          DialogStrings.busExplanation,
                        ),
                        const SizedBox(height: 16),
                        _hintRow(
                          ctx,
                          CupertinoIcons.square_list,
                          DialogStrings.channels,
                          DialogStrings.channelsExplanation,
                        ),
                        const SizedBox(height: 16),
                        _hintRow(
                          ctx,
                          CupertinoIcons.timer,
                          DialogStrings.cas,
                          DialogStrings.casExplanation,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: () => Navigator.pop(ctx),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: const Text(DialogStrings.gotit),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _hintRow(
    BuildContext ctx,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final color = CupertinoTheme.of(ctx).primaryColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(subtitle),
            ],
          ),
        ),
      ],
    );
  }

  static Future<void> showErrorDialog(
    BuildContext context,
    String message,
  ) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) {
        return CupertinoAlertDialog(
          title: const Text(DialogStrings.error),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text(DialogStrings.ok),
              onPressed: () => Navigator.pop(dialogContext),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showAboutDialog(BuildContext context) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset('assets/appicon.png'),
            ),
            const SizedBox(width: 10),
            const Text('RAMspeed'),
          ],
        ),
        content: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            'Version ${Strings.appVersion}\n\n'
            // Not worth fixing.
            // ignore: lines_longer_than_80_chars
            '© 2020-2026 Anirudh Menon. GNU GPL v3 license. All rights reserved.\n'
            'For feature suggestions/bug reports, open an issue on GitHub.',
            style: TextStyle(fontSize: 13),
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
