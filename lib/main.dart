import 'package:flutter/material.dart';
import 'package:ramspeed/main_scaffold.dart';

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
    return MaterialApp(
      title: 'RAMSpeed',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: isDark ? Colors.blueAccent : Colors.lightBlueAccent,
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
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
