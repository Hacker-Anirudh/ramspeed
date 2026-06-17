import 'package:flutter/cupertino.dart';
import 'package:ramspeed/cupertino_ui/main_scaffold.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'RAMSpeed',
      theme: CupertinoThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      home: Builder(
        builder: (context) => MainScaffold(
          isDark: isDark,
          onThemeToggle: () {
            setState(() {
              isDark = !isDark;
            });
          },
        ),
      ),
    );
  }
}
