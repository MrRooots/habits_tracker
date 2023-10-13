import 'package:dartz/dartz.dart';
import 'package:habits_tracker/core/exceptions/failures.dart';
import 'package:habits_tracker/core/usecases/usecase.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/domain/repositories/repository.dart';

final class DeleteHabitParams {
  final HabitEntity habit;

  const DeleteHabitParams({required this.habit});
}

final class DeleteHabitUseCase extends UseCase<HabitEntity, DeleteHabitParams> {
  final HabitRepository repository;

  DeleteHabitUseCase({required this.repository});

  @override
  Future<Either<HabitEntity, Failure>> call(
    final DeleteHabitParams params,
  ) async {
    return await repository.deleteHabit(habit: params.habit);
  }
}
