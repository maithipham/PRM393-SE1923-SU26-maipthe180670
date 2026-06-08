import 'package:flutter/material.dart';

class SortBar extends StatelessWidget {
  final String selectedSort;
  final ValueChanged<String?> onSortChanged;
  final bool showClearButton;
  final VoidCallback onClearPressed;

  const SortBar({
    super.key,
    required this.selectedSort,
    required this.onSortChanged,
    required this.showClearButton,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Sort by:  ',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color(0xFF1F1F2C),
              ),
              child: DropdownButton<String>(
                value: selectedSort,
                style: const TextStyle(color: Colors.white),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                underline: Container(height: 1, color: Colors.deepPurple),
                onChanged: onSortChanged,
                items: <String>['A-Z', 'Z-A', 'Year', 'Rating']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
              ),
            )
          ],
        ),
        if (showClearButton)
          TextButton.icon(
            onPressed: onClearPressed,
            icon: const Icon(Icons.clear_all, size: 18, color: Colors.redAccent),
            label: const Text('Clear Filters', style: TextStyle(color: Colors.redAccent, fontSize: 12)),
          )
      ],
    );
  }
}