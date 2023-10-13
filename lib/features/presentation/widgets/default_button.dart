import 'package:flutter/material.dart';
import 'package:habits_tracker/core/themes/palette.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final String? text;
  final Color? buttonColor;
  final void Function() onPressed;

  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.width,
    this.text,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: width,
      child: SizedBox(
        height: 56.0,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? Palette.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: onPressed,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: text != null
                ? Text(
                    text!,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  )
                : const CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
