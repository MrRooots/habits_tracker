part of 'habit_bloc.dart';

enum HabitStateStatus {
  initial,
  loading,
  createSuccess,
  editSuccess,
  deleteSuccess,
  createFailed,
  editFailed,
  deleteFailed,
  completeFailed,
  canDoMore,
  cantDoMore,
}

final class HabitState extends Equatable {
  final HabitEntity? habit;
  final String message;
  final HabitStateStatus status;
  final String snackBarMessage;

  const HabitState({
    this.habit,
    this.status = HabitStateStatus.initial,
    this.message = '',
    this.snackBarMessage = '',
  });

  bool get isInitial => status == HabitStateStatus.initial;

  bool get isLoading => status == HabitStateStatus.loading;

  bool get isCreateSuccess => status == HabitStateStatus.createSuccess;

  bool get isDeleteSuccess => status == HabitStateStatus.deleteSuccess;

  bool get isEditSuccess => status == HabitStateStatus.editSuccess;

  bool get isCreateFailed => status == HabitStateStatus.createFailed;

  bool get isEditFailed => status == HabitStateStatus.editFailed;

  bool get isDeleteFailed => status == HabitStateStatus.deleteFailed;

  bool get isCompleteFailed => status == HabitStateStatus.completeFailed;

  bool get isCanDoMore => status == HabitStateStatus.canDoMore;

  bool get isCantDoMore => status == HabitStateStatus.cantDoMore;

  bool get isSuccess =>
      isDeleteSuccess ||
      isEditSuccess ||
      isCreateSuccess ||
      isCantDoMore ||
      isCanDoMore;

  bool get isFailed => isDeleteFailed || isEditFailed || isCreateFailed;

  @override
  List<Object?> get props => [habit, status.name, message];

  HabitState copyWith({
    final HabitEntity? habit,
    final HabitStateStatus? status,
    final String? message,
    final String? snackBarMessage,
  }) =>
      HabitState(
        habit: habit ?? this.habit,
        status: status ?? this.status,
        message: message ?? this.message,
        snackBarMessage: snackBarMessage ?? this.snackBarMessage,
      );
}
