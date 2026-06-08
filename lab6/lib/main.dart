import 'package:flutter/material.dart';
import 'package:lab6/pages/genre_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Movie Browser',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF14141B), // Nền tối chuẩn app xem phim
      ),
      debugShowCheckedModeBanner: false,
      home: const GenreScreen(),
    );
  }
}



