import 'package:dartz/dartz.dart';
import 'package:habits_tracker/core/exceptions/failures.dart';
import 'package:habits_tracker/core/usecases/usecase.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/domain/repositories/repository.dart';

final class CreateHabitParams {
  final String title;
  final String description;
  final HabitType type;
  final Priority priority;
  final int count;
  final int frequency;

  const CreateHabitParams({
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.count,
    required this.frequency,
  });
}

final class CreateHabitUseCase extends UseCase<HabitEntity, CreateHabitParams> {
  final HabitRepository repository;

  CreateHabitUseCase({required this.repository});

  @override
  Future<Either<HabitEntity, Failure>> call(
    final CreateHabitParams params,
  ) async {
    return await repository.createHabit(
      title: params.title,
      description: params.description,
      type: params.type,
      priority: params.priority,
      count: params.count,
      frequency: params.frequency,
    );
  }
}
