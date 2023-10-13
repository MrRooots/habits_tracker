import 'package:flutter/material.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/themes/palette.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';

final class Utils {
  /// Get [Color] for given [priority]
  ///
  /// Returns [Color]
  static Color getPriorityColor({required Priority priority}) {
    return priority == Priority.low
        ? Palette.lightGreenSalad
        : priority == Priority.medium
            ? Palette.yellow
            : Palette.lightRed;
  }

  /// Get [Color] for given [type]
  ///
  /// Returns [Color]
  static Color getTypeColor({required HabitType type}) {
    return type == HabitType.good ? Palette.lightGreenSalad : Palette.lightRed;
  }

  /// Get current time of day as string
  ///
  /// Returns [String] - name of day part
  static String get timeOfDay {
    final int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour <= 17) {
      return 'Day';
    } else if (hour > 17 && hour <= 21) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }

  /// Calculate the interval for [frequency] in milliseconds since epoch
  /// for current date.
  ///
  /// For available [frequency] values see [Constants.frequencies]
  ///
  /// Returns [List] of [int]: [start, end]
  static List<int> intervalFor(final int frequency) {
    DateTime now = DateTime.now();

    if (frequency == 0) {
      final DateTime dayStart = DateTime(now.year, now.month, now.day);
      final DateTime dayEnd = dayStart.add(const Duration(days: 1));

      return [dayStart.millisecondsSinceEpoch, dayEnd.millisecondsSinceEpoch];
    } else if (frequency == 1) {
      final DateTime weekStart = DateTime(now.year, now.month, now.day, 0, 0, 0)
          .subtract(Duration(days: now.weekday - 1));
      final DateTime weekEnd = weekStart
          .add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

      return [weekStart.millisecondsSinceEpoch, weekEnd.millisecondsSinceEpoch];
    } else if (frequency == 2) {
      final DateTime monthStart = DateTime(now.year, now.month, 1, 0, 0, 0);
      final DateTime monthEnd = DateTime(now.year, now.month + 1, 1, 0, 0, 0)
          .subtract(const Duration(seconds: 1));

      return [
        monthStart.millisecondsSinceEpoch,
        monthEnd.millisecondsSinceEpoch
      ];
    } else {
      throw UnimplementedError();
    }
  }
}
