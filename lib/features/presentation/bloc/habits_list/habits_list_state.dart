part of 'habits_list_bloc.dart';

enum HabitsStateStatus { initial, loading, success, failed }

final class HabitsListState extends Equatable {
  final List<HabitEntity> habits;
  final HabitsStateStatus status;
  final String message;

  const HabitsListState({
    this.habits = const [],
    this.status = HabitsStateStatus.initial,
    this.message = '',
  });

  bool get isInitial => status == HabitsStateStatus.initial;

  bool get isLoading => status == HabitsStateStatus.loading;

  bool get isSuccess => status == HabitsStateStatus.success;

  bool get isFailed => status == HabitsStateStatus.failed;

  @override
  List<Object?> get props => [habits, status, message];

  HabitsListState copyWith({
    final List<HabitEntity>? habits,
    final HabitsStateStatus? status,
    final String? message,
  }) =>
      HabitsListState(
        habits: habits ?? this.habits,
        status: status ?? this.status,
        message: message ?? this.message,
      );
}
