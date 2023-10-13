import 'package:flutter/material.dart';
import 'package:habits_tracker/core/services/utilities.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';

class DropDownSelect extends StatefulWidget {
  final Priority initialPriority;

  final ValueChanged<Priority> onChanged;

  const DropDownSelect({
    super.key,
    required this.onChanged,
    this.initialPriority = Priority.low,
  });

  @override
  State<DropDownSelect> createState() => DropDownSelectState();
}

class DropDownSelectState extends State<DropDownSelect> {
  Priority _priority = Priority.low;

  @override
  void initState() {
    super.initState();

    _priority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    final Color priorityColor = Utils.getPriorityColor(priority: _priority);

    return DropdownButtonFormField(
      value: _priority,
      onChanged: (final value) {
        setState(() => _priority = value!);
        widget.onChanged(value!);
      },
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: priorityColor, width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: priorityColor, width: 2),
        ),
      ),
      items: Priority.values
          .map(
            (final Priority priority) => DropdownMenuItem<Priority>(
              value: priority,
              child: Row(
                children: [
                  Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: Utils.getPriorityColor(priority: priority),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(priority.name)
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
