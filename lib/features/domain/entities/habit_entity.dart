import 'package:equatable/equatable.dart';

enum Priority { high, medium, low }

enum HabitType { good, bad }

class HabitEntity extends Equatable {
  final String uid;
  final String title;
  final String description;
  final HabitType type;
  final Priority priority;
  final int date;
  final int count;
  final int frequency;
  final List<int> doneDates;
  final int color;

  const HabitEntity({
    required this.uid,
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.date,
    required this.count,
    required this.frequency,
    required this.doneDates,
    required this.color,
  });

  @override
  List<Object> get props => [
        uid,
        title,
        description,
        type,
        priority,
        date,
        count,
        frequency,
        doneDates,
        color,
      ];
}
