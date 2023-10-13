import 'package:dartz/dartz.dart';

import 'package:habits_tracker/core/exceptions/exceptions.dart';
import 'package:habits_tracker/core/exceptions/failures.dart';
import 'package:habits_tracker/core/services/network_info.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/data/datasources/local_data_source.dart';
import 'package:habits_tracker/features/data/datasources/remote_data_source.dart';
import 'package:habits_tracker/features/data/models/habit_model.dart';
import 'package:habits_tracker/features/domain/repositories/repository.dart';

final class HabitRepositoryImpl implements HabitRepository {
  final NetworkInfo networkInfo;
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  const HabitRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<List<HabitEntity>, Failure>> readAllHabits({
    required final HabitType type,
    required final bool sortByDate,
    final String query = '',
  }) async {
    try {
      final List<HabitModel> habits = await localDataSource.readAllHabits(
        type: type,
        sortByDate: sortByDate,
        query: query,
      );

      return left(habits);
    } on CacheException catch (e) {
      return right(CacheFailure(code: e.code, message: e.message));
    } on UndefinedException catch (e) {
      return right(UndefinedFailure(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<HabitEntity, Failure>> createHabit({
    required final String title,
    required final String description,
    required final HabitType type,
    required final Priority priority,
    required final int count,
    required final int frequency,
  }) async {
    try {
      final HabitModel habit = await remoteDataSource.createHabit(
        title: title,
        description: description,
        type: type,
        date: DateTime.now().millisecondsSinceEpoch,
        priority: priority,
        count: count,
        frequency: frequency,
      );

      return left(await localDataSource.createHabit(habit: habit));
    } on CacheException catch (e) {
      return right(CacheFailure(code: e.code, message: e.message));
    } on FormatException catch (e) {
      return right(FormatFailure(code: e.code, message: e.message));
    } on RequestException catch (e) {
      return right(RequestFailure(code: e.code, message: e.message));
    } on ServerException catch (e) {
      return right(ServerFailure(code: e.code, message: e.message));
    } on ConnectionException catch (e) {
      return right(ConnectionFailure(code: e.code, message: e.message));
    } on UndefinedException catch (e) {
      return right(UndefinedFailure(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<HabitEntity, Failure>> updateHabit({
    required final HabitEntity oldHabit,
    final String? title,
    final String? description,
    final HabitType? type,
    final Priority? priority,
    final int? count,
    final int? frequency,
    final List<int>? doneDates,
  }) async {
    try {
      final HabitModel newHabit = (oldHabit as HabitModel).copyWith(
        title: title,
        description: description,
        type: type,
        priority: priority,
        date: DateTime.now().millisecondsSinceEpoch,
        count: count,
        frequency: frequency,
        doneDates: doneDates,
      );

      await remoteDataSource.updateHabit(newHabit: newHabit);

      return left(await localDataSource.updateHabit(newHabit: newHabit));
    } on CacheException catch (e) {
      return right(CacheFailure(code: e.code, message: e.message));
    } on FormatException catch (e) {
      return right(FormatFailure(code: e.code, message: e.message));
    } on RequestException catch (e) {
      return right(RequestFailure(code: e.code, message: e.message));
    } on ServerException catch (e) {
      return right(ServerFailure(code: e.code, message: e.message));
    } on ConnectionException catch (e) {
      return right(ConnectionFailure(code: e.code, message: e.message));
    } on UndefinedException catch (e) {
      return right(UndefinedFailure(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<HabitEntity, Failure>> deleteHabit({
    required final HabitEntity habit,
  }) async {
    try {
      await remoteDataSource.deleteHabit(habit: habit as HabitModel);

      return left(await localDataSource.deleteHabit(habit: habit));
    } on CacheException catch (e) {
      return right(CacheFailure(code: e.code, message: e.message));
    } on RequestException catch (e) {
      return right(RequestFailure(code: e.code, message: e.message));
    } on ServerException catch (e) {
      return right(ServerFailure(code: e.code, message: e.message));
    } on ConnectionException catch (e) {
      return right(ConnectionFailure(code: e.code, message: e.message));
    } on UndefinedException catch (e) {
      return right(UndefinedFailure(code: e.code, message: e.message));
    }
  }
}
