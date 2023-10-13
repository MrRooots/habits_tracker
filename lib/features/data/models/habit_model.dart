import 'package:habits_tracker/features/domain/entities/habit_entity.dart';

final class HabitModel extends HabitEntity {
  const HabitModel({
    required super.uid,
    required super.title,
    required super.description,
    required super.type,
    required super.priority,
    required super.date,
    required super.count,
    required super.frequency,
    required super.doneDates,
    required super.color,
  });

  HabitModel copyWith({
    final String? title,
    final String? description,
    final HabitType? type,
    final Priority? priority,
    final int? date,
    final int? count,
    final List<int>? doneDates,
    final int? frequency,
  }) {
    return HabitModel(
      uid: uid,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      count: count ?? this.count,
      frequency: frequency ?? this.frequency,
      doneDates: doneDates ?? this.doneDates,
      color: color,
    );
  }

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      type: HabitType.values[json['type']],
      priority: Priority.values[json['priority']],
      date: json['date'],
      count: json['count'],
      frequency: json['frequency'],
      doneDates: (json['done_dates'] ?? const <int>[]).cast<int>(),
      color: json['color'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
      'type': type.index,
      'priority': priority.index,
      'date': date,
      'count': count,
      'frequency': frequency,
      'done_dates': doneDates,
      'color': color,
    };
  }

  /// Check if model fields are valid
  ///
  /// Currently checking for title and description
  bool get isValid => title.isNotEmpty && description.isNotEmpty;
}
