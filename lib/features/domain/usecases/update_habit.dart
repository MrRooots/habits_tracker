import 'package:dartz/dartz.dart';
import 'package:habits_tracker/core/exceptions/failures.dart';
import 'package:habits_tracker/core/usecases/usecase.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/domain/repositories/repository.dart';

final class UpdateHabitParams {
  final HabitEntity oldHabit;
  final String? title;
  final String? description;
  final HabitType? type;
  final Priority? priority;
  final int? count;
  final int? frequency;
  final List<int>? doneDates;

  const UpdateHabitParams({
    required this.oldHabit,
    this.title,
    this.description,
    this.type,
    this.priority,
    this.count,
    this.frequency,
    this.doneDates,
  });
}

final class UpdateHabitUseCase extends UseCase<HabitEntity, UpdateHabitParams> {
  final HabitRepository repository;

  UpdateHabitUseCase({required this.repository});

  @override
  Future<Either<HabitEntity, Failure>> call(
    final UpdateHabitParams params,
  ) async {
    return await repository.updateHabit(
      oldHabit: params.oldHabit,
      title: params.title,
      description: params.description,
      type: params.type,
      priority: params.priority,
      count: params.count,
      frequency: params.frequency,
      doneDates: params.doneDates,
    );
  }
}
