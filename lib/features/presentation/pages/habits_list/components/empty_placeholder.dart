import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: Image(image: AssetImage('assets/images/empty.png'))),
          Text(
            'There is no any habits!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'You can add them by clickng green\nfloating button :)',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
