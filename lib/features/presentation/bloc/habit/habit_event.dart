part of 'habit_bloc.dart';

sealed class HabitEvent extends Equatable {
  const HabitEvent();
}

final class CreateHabitEvent extends HabitEvent {
  final String title;
  final String description;
  final HabitType type;
  final Priority priority;
  final int count;
  final int frequency;

  const CreateHabitEvent({
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.count,
    required this.frequency,
  });

  @override
  List<Object> get props => [
        title,
        description,
        type,
        priority,
        count,
        frequency,
      ];
}

final class UpdateHabitEvent extends HabitEvent {
  final HabitEntity oldHabit;
  final String? title;
  final String? description;
  final HabitType? type;
  final Priority? priority;
  final int? count;
  final int? frequency;

  const UpdateHabitEvent({
    required this.oldHabit,
    this.title,
    this.description,
    this.type,
    this.priority,
    this.count,
    this.frequency,
  });

  @override
  List<Object?> get props => [
        oldHabit,
        title,
        description,
        type,
        priority,
        count,
        frequency,
      ];
}

final class DeleteHabitEvent extends HabitEvent {
  final HabitEntity habit;

  const DeleteHabitEvent({required this.habit});

  @override
  List<Object> get props => [habit];
}

final class CompleteHabitEvent extends HabitEvent {
  final HabitEntity habit;

  const CompleteHabitEvent({required this.habit});

  @override
  List<Object> get props => [habit];
}
