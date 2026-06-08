import 'package:flutter/material.dart';

class GenreChips extends StatelessWidget {
  final List<String> availableGenres;
  final String selectedGenre;
  final ValueChanged<String> onGenreSelected;

  const GenreChips({
    super.key,
    required this.availableGenres,
    required this.selectedGenre,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Genres',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: availableGenres.map((genre) {
            final bool isSelected = selectedGenre == genre;
            return ChoiceChip(
              label: Text(genre),
              selected: isSelected,
              selectedColor: Colors.deepPurple,
              backgroundColor: const Color(0xFF1F1F2C),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[300],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (bool selected) {
                if (selected) onGenreSelected(genre);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}