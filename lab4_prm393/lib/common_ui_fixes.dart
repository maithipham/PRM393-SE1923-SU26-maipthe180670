import 'package:flutter/material.dart';

class CommonUiFixes extends StatelessWidget {
  const CommonUiFixes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 5 – Common U..."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Correct ListView inside Column using Expanded",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<String> movieLetters = ["A", "B", "C", "D"];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    leading: const Icon(Icons.movie_creation, size: 30),
                    title: Text(
                      "Movie ${movieLetters[index]}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}