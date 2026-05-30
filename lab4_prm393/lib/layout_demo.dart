import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  LayoutDemo({super.key});

  final List<Map<String, String>> movieItems = [
    {"title": "Avatar", "letter": "A"},
    {"title": "Inception", "letter": "I"},
    {"title": "Interstellar", "letter": "I"},
    {"title": "Joker", "letter": "J"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 3 – Layout De..."),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          const Center(
            child: Text(
              "Now Playing",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              itemCount: movieItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                final item = movieItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: const Color(0xFFF8F8FA),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: const Color(0xFFE0E2F5),
                        child: Text(
                          item["letter"]!,
                          style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        item["title"]!,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      subtitle: const Text("Sample description", style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}