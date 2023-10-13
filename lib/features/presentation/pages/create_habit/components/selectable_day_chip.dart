import 'package:flutter/material.dart';
import 'package:habits_tracker/core/themes/palette.dart';

class SelectableDayChip extends StatelessWidget {
  final String day;
  final bool isSelected;

  const SelectableDayChip({
    super.key,
    required this.day,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected ? Palette.lightGreenSalad : Palette.lightGrey,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? Palette.lightGreenSalad : Palette.grey,
          ),
        ),
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Palette.white : Palette.grey,
          ),
        ),
      ),
    );
  }
}
