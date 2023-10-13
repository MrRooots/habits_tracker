import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/services/extensions.dart';
import 'package:habits_tracker/core/themes/palette.dart';
import 'package:habits_tracker/core/services/utilities.dart';

import 'package:habits_tracker/features/domain/entities/habit_entity.dart';

import 'package:habits_tracker/features/presentation/bloc/habit/habit_bloc.dart';
import 'package:habits_tracker/features/presentation/pages/create_habit/habit_form.dart';
import 'package:habits_tracker/features/presentation/pages/habits_list/components/confirm_alert_dialog.dart';

class HabitCard extends StatelessWidget {
  final HabitEntity habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<HabitBloc>(context),
          child: HabitFormPage(habit: habit),
        ),
      )),
      onLongPress: () async {
        final bool? confirmed = await showDialog(
          context: context,
          builder: (context) => ConfirmAlertDialog(title: habit.title),
        );

        if (context.mounted && (confirmed ?? false)) {
          BlocProvider.of<HabitBloc>(context)
              .add(DeleteHabitEvent(habit: habit));
        }
      },
      child: Card(
        elevation: 2.0,
        shadowColor: Utils.getTypeColor(type: habit.type),
        child: Container(
          color: Utils.getTypeColor(type: habit.type).withOpacity(.1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _habitInfoBlock(context),
                _completeHabit(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Left block with all habit information
  Expanded _habitInfoBlock(final BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                habit.title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                height: 8.0,
                width: 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Utils.getPriorityColor(
                    priority: habit.priority,
                  ),
                ),
              ),
            ],
          ),
          Text(
            DateFormat.yMMMMd().format(
              DateTime.fromMillisecondsSinceEpoch(habit.date),
            ),
            style: const TextStyle(color: Palette.grey),
          ),
          Text(
            '${habit.priority.name.capitalize()} priority '
            '(${habit.type.name.capitalize()})',
          ),
          Text(
            'Repeat ${habit.count} time${habit.count > 1 ? 's' : ''}'
            ' per ${Constants.frequencies[habit.frequency].toLowerCase()}',
          ),
          if (habit.description.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              width: MediaQuery.of(context).size.width * .8,
              child: Text(habit.description, maxLines: 4),
            ),
        ],
      ),
    );
  }

  /// Right block with "complete habit" button
  Expanded _completeHabit(final BuildContext context) {
    return Expanded(
      flex: 1,
      child: IconButton(
        onPressed: () => BlocProvider.of<HabitBloc>(context)
            .add(CompleteHabitEvent(habit: habit)),
        iconSize: 36.0,
        tooltip: 'Mark done',
        icon: ImageIcon(
          const AssetImage('assets/images/complete.png'),
          color: habit.type == HabitType.good
              ? Palette.lightGreenSalad
              : Palette.lightRed,
        ),
      ),
    );
  }
}
