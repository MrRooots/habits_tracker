import 'package:flutter/material.dart';

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
          Text(
            message,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
