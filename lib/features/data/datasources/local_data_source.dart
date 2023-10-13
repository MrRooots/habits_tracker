import 'package:hive_flutter/hive_flutter.dart';

import 'package:habits_tracker/core/constants/constants.dart';

import 'package:habits_tracker/core/exceptions/exceptions.dart';
import 'package:habits_tracker/core/services/hive_manager.dart';

import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/data/models/habit_model.dart';

abstract interface class LocalDataSource {
  /// Get all habits from database
  ///
  /// Throws [CacheException] or [UndefinedException]
  Future<List<HabitModel>> readAllHabits({
    required final HabitType type,
    required final bool sortByDate,
    required final String query,
  });

  /// Save new habit to database
  ///
  /// Throws [CacheException], [FormatException] or [UndefinedException]
  Future<HabitModel> createHabit({required final HabitModel habit});

  /// Update existing habit in database
  ///
  /// Throws [CacheException], [FormatException] or [UndefinedException]
  Future<HabitModel> updateHabit({required final HabitModel newHabit});

  /// Delete habit from database
  ///
  /// Throws [CacheException] or [UndefinedException]
  Future<HabitModel> deleteHabit({required final HabitModel habit});
}

final class LocalDataSourceImpl implements LocalDataSource {
  final HiveManager hiveManager;

  const LocalDataSourceImpl({required this.hiveManager});

  @override
  Future<List<HabitModel>> readAllHabits({
    required final HabitType type,
    required final bool sortByDate,
    required final String query,
  }) async {
    try {
      final Box<HabitModel> box = await hiveManager.openHabitBox();
      final List<HabitModel> habits = box.values
          .where((habit) =>
              habit.type == type && habit.title.toLowerCase().contains(query))
          .toList();

      if (sortByDate) {
        habits.sort((a, b) => b.date.compareTo(a.date));
      } else {
        habits.sort((a, b) => a.priority.index.compareTo(b.priority.index));
      }

      return habits;
    } on HiveError {
      throw const CacheException(
        code: 0,
        message: 'Failed to load habits from database',
      );
    } on Exception catch (e) {
      throw UndefinedException(
        code: 0,
        message: e.toString(),
      );
    }
  }

  @override
  Future<HabitModel> createHabit({required final HabitModel habit}) async {
    if (!habit.isValid) {
      throw const FormatException(code: 0, message: Constants.formatError);
    }

    try {
      final Box<HabitModel> box = await hiveManager.openHabitBox();

      await box.put(habit.uid, habit);

      return habit;
    } on HiveError {
      throw const CacheException(
        code: 0,
        message: 'Failed to save habits to database',
      );
    } on Exception catch (e) {
      throw UndefinedException(
        code: 0,
        message: e.toString(),
      );
    }
  }

  @override
  Future<HabitModel> updateHabit({required HabitModel newHabit}) async {
    if (!newHabit.isValid) {
      throw const FormatException(code: 0, message: Constants.formatError);
    }

    try {
      final Box<HabitModel> box = await hiveManager.openHabitBox();

      await box.put(newHabit.uid, newHabit);

      return newHabit;
    } on HiveError {
      throw const CacheException(
        code: 0,
        message: 'Failed to update habit in database',
      );
    } on Exception catch (e) {
      throw UndefinedException(
        code: 0,
        message: e.toString(),
      );
    }
  }

  @override
  Future<HabitModel> deleteHabit({required final HabitModel habit}) async {
    try {
      final Box<HabitModel> box = await hiveManager.openHabitBox();

      await box.delete(habit.uid);

      return habit;
    } on HiveError {
      throw const CacheException(
        code: 0,
        message: 'Failed to delete habit from database',
      );
    } on Exception catch (e) {
      throw UndefinedException(
        code: 0,
        message: e.toString(),
      );
    }
  }
}
