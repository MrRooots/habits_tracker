import 'package:flutter/material.dart';
import 'package:habits_tracker/core/themes/palette.dart';

class NumericStepButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;

  final ValueChanged<int> onChanged;

  const NumericStepButton({
    Key? key,
    this.minValue = 1,
    this.maxValue = 200,
    this.initialValue = 1,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  int counter = 1;

  @override
  void initState() {
    super.initState();

    counter = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          iconSize: 32.0,
          color: Palette.lightGreenSalad,
          onPressed: counter > widget.minValue
              ? () {
                  setState(() {
                    if (counter > widget.minValue) {
                      counter--;
                    }
                    widget.onChanged(counter);
                  });
                }
              : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              Text(
                '$counter',
                style: const TextStyle(
                  color: Palette.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('time${counter > 1 ? 's' : ''}')
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          iconSize: 32.0,
          color: Palette.lightGreenSalad,
          onPressed: counter < widget.maxValue
              ? () {
                  setState(() {
                    if (counter < widget.maxValue) {
                      counter++;
                      widget.onChanged(counter);
                    }
                  });
                }
              : null,
        ),
      ],
    );
  }
}
