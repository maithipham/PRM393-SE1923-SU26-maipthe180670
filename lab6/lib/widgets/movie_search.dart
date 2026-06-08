import 'package:flutter/material.dart';

class MovieSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const MovieSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F2C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Search movie by title...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}