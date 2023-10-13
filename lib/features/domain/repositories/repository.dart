import 'package:dartz/dartz.dart';

import 'package:habits_tracker/core/exceptions/failures.dart';
import 'package:habits_tracker/core/exceptions/exceptions.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';

abstract interface class HabitRepository {
  /// Get all habits
  ///
  /// Returns list of [HabitEntity]
  ///
  /// Throws [CacheException] on errors
  Future<Either<List<HabitEntity>, Failure>> readAllHabits({
    required final bool sortByDate,
    required final HabitType type,
    final String query = '',
  });

  /// Create new habit
  ///
  /// Throws [CacheException], [ServerException], [RequestException],
  /// [ConnectionException]
  Future<Either<HabitEntity, Failure>> createHabit({
    required final String title,
    required final String description,
    required final HabitType type,
    required final Priority priority,
    required final int count,
    required final int frequency,
  });

  /// Update specific habit
  ///
  /// Throws [CacheException], [ServerException], [RequestException],
  /// [ConnectionException]
  Future<Either<HabitEntity, Failure>> updateHabit({
    required final HabitEntity oldHabit,
    final String? title,
    final String? description,
    final HabitType? type,
    final Priority? priority,
    final int? count,
    final int? frequency,
    final List<int>? doneDates,
  });

  /// Delete specific habit
  ///
  /// Throws [CacheException], [ServerException], [RequestException],
  /// [ConnectionException]
  Future<Either<HabitEntity, Failure>> deleteHabit({
    required final HabitEntity habit,
  });
}
