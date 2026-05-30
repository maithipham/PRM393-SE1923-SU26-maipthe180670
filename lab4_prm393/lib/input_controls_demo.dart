import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _currentRating = 50.0;
  bool _isMovieActive = false;
  String _selectedGenre = "None";

  void _openDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selected Date: ${picked.day}/${picked.month}/${picked.year}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 2 – Input Contr..."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Rating (Slider)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: _currentRating,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() { _currentRating = value; });
              },
            ),
            Text("Current value: ${_currentRating.round()}", style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),

            const Text("Active (Switch)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Is movie active?", style: TextStyle(fontSize: 15)),
                Switch(
                  value: _isMovieActive,
                  onChanged: (value) {
                    setState(() { _isMovieActive = value; });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text("Genre (RadioListTile)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text("Action"),
              value: "Action",
              groupValue: _selectedGenre,
              onChanged: (value) {
                setState(() { _selectedGenre = value!; });
              },
            ),
            RadioListTile<String>(
              title: const Text("Comedy"),
              value: "Comedy",
              groupValue: _selectedGenre,
              onChanged: (value) {
                setState(() { _selectedGenre = value!; });
              },
            ),
            Text("Selected genre: $_selectedGenre", style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _openDatePicker(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: const Color(0xFFF0F0F5),
                ),
                child: const Text("Open Date Picker", style: TextStyle(color: Colors.indigo)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}