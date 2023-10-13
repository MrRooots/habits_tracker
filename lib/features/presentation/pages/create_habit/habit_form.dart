import 'package:flutter/material.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/presentation/pages/create_habit/components/body.dart';

class HabitFormPage extends StatelessWidget {
  final HabitEntity? habit;

  const HabitFormPage({super.key, this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit == null ? 'Create Habit' : 'Edit Habit'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          splashRadius: 0.01,
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: HabitFormBody(habit: habit),
            ),
          ],
        ),
      ),
    );
  }
}
