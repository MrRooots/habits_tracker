import 'package:dartz/dartz.dart';
import 'package:habits_tracker/core/exceptions/failures.dart';
import 'package:habits_tracker/core/usecases/usecase.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/domain/repositories/repository.dart';

final class ReadAllHabitsParams {
  final bool sortByDate;
  final HabitType type;
  final String query;

  const ReadAllHabitsParams({
    required this.type,
    this.sortByDate = false,
    this.query = '',
  });
}

final class ReadAllHabitsUseCase
    extends UseCase<List<HabitEntity>, ReadAllHabitsParams> {
  final HabitRepository repository;

  ReadAllHabitsUseCase({required this.repository});

  @override
  Future<Either<List<HabitEntity>, Failure>> call(
    final ReadAllHabitsParams params,
  ) async {
    return await repository.readAllHabits(
      sortByDate: params.sortByDate,
      type: params.type,
      query: params.query,
    );
  }
}
