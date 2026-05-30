import 'package:flutter/material.dart';

class AppStructureTheme extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const AppStructureTheme({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<AppStructureTheme> createState() => _AppStructureThemeState();
}

class _AppStructureThemeState extends State<AppStructureTheme> {
   late bool _localIsDarkMode;

  @override
  void initState() {
    super.initState();
    _localIsDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
     final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
       appBar: AppBar(
        title: const Text("Exercise 4 – App Str..."),
        actions: [
          Row(
            children: [
              const Text(
                "Dark",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 4),
              Switch(
                value: isDarkTheme,
                onChanged: (value) {
                   setState(() {
                    _localIsDarkMode = value;
                  });
                   widget.onThemeChanged(value);
                },
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),

       body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "This is a simple screen with theme toggle.",
                style: TextStyle(
                  fontSize: 15,
                   color: isDarkTheme ? Colors.white70 : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}