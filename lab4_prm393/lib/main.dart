import 'package:flutter/material.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_demo.dart';
import 'app_structure_theme.dart';
import 'common_ui_fixes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 – Flutter UI Fundamentals',

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F5F7),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),

      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: MainDashboard(
        isDarkMode: _isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}

class MainDashboard extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MainDashboard({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab 4 – Flutter UI Fundamentals"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            //Exercise 1
            _buildMenuButton(context, "Exercise 1 – Core Widgets Demo", const CoreWidgetsDemo()),

            //Exercise 2
            _buildMenuButton(context, "Exercise 2 – Input Controls Demo", const InputControlsDemo()),

            //Exercise 3
            _buildMenuButton(context, "Exercise 3 – Layout Demo", LayoutDemo()),

            //Exercise 4
            _buildMenuButton(
              context,
              "Exercise 4 – App Structure & Theme",
              AppStructureTheme(isDarkMode: isDarkMode, onThemeChanged: onThemeChanged),
            ),

            //Exercise 5
            _buildMenuButton(context, "Exercise 5 – Common UI Fixes", const CommonUiFixes()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, Widget targetPage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFFF8F8FA),
        child: ListTile(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => targetPage));
          },
        ),
      ),
    );
  }
}