import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 1 – Core Widgets"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Welcome to Flutter UI",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(16),

              child: const Icon(
                Icons.movie_creation_rounded,
                color: Colors.blue,
                size: 60,
              ),
            ),
            const SizedBox(height: 40),

            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),

            Card(
              elevation: 2,
              color: const Color(0xFFF5F5F7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.star, color: Colors.black54, size: 28),
                title: Text(
                  "Movie Item",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                subtitle: Text("This is a sample ListTile inside a Card."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}