import 'package:flutter/material.dart';
import 'package:habits_tracker/core/themes/palette.dart';

class LoadingErrorPlaceholder extends StatelessWidget {
  final String message;

  const LoadingErrorPlaceholder({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            child: Image(image: AssetImage('assets/images/empty.png')),
          ),
          const Text(
            'Failed to load habits!',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Palette.red,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
