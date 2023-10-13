import 'package:flutter/material.dart';
import 'package:habits_tracker/core/themes/palette.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final String title;

  const ConfirmAlertDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete?'),
      content: Text(
        'Are you sure you want to delete "$title" habit?',
        style: const TextStyle(fontSize: 14.0),
      ),
      titlePadding: const EdgeInsets.all(16.0),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.lightGreenSalad,
          ),
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.lightRed,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
