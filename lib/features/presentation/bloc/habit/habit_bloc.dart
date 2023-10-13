import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/services/utilities.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/domain/usecases/create_habit.dart';
import 'package:habits_tracker/features/domain/usecases/delete_habit.dart';
import 'package:habits_tracker/features/domain/usecases/update_habit.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  CreateHabitUseCase createHabit;
  UpdateHabitUseCase updateHabit;
  DeleteHabitUseCase deleteHabit;

  HabitBloc({
    required this.createHabit,
    required this.updateHabit,
    required this.deleteHabit,
  }) : super(const HabitState()) {
    on<CreateHabitEvent>(_onCreateHabit);
    on<UpdateHabitEvent>(_onUpdateHabit);
    on<DeleteHabitEvent>(_onDeleteHabit);
    on<CompleteHabitEvent>(_onCompleteHabit);
  }

  Future<void> _onCreateHabit(
    final CreateHabitEvent event,
    final Emitter<HabitState> emit,
  ) async {
    emit(state.copyWith(message: '', status: HabitStateStatus.loading));

    final habitOrFailure = await createHabit(CreateHabitParams(
      title: event.title,
      description: event.description,
      type: event.type,
      priority: event.priority,
      count: event.count,
      frequency: event.frequency,
    ));

    habitOrFailure.fold(
      (habit) => emit(state.copyWith(
        habit: habit,
        message: '',
        status: HabitStateStatus.createSuccess,
      )),
      (failure) => emit(state.copyWith(
        message: failure.message,
        status: HabitStateStatus.createFailed,
      )),
    );
  }

  Future<void> _onUpdateHabit(
    final UpdateHabitEvent event,
    final Emitter<HabitState> emit,
  ) async {
    emit(state.copyWith(message: '', status: HabitStateStatus.loading));

    final habitOrFailure = await updateHabit(UpdateHabitParams(
      oldHabit: event.oldHabit,
      title: event.title,
      description: event.description,
      type: event.type,
      priority: event.priority,
      count: event.count,
      frequency: event.frequency,
    ));

    habitOrFailure.fold(
      (habit) => emit(state.copyWith(
        habit: habit,
        message: '',
        status: HabitStateStatus.editSuccess,
      )),
      (failure) => emit(state.copyWith(
        message: failure.message,
        status: HabitStateStatus.editFailed,
      )),
    );
  }

  Future<void> _onDeleteHabit(
    final DeleteHabitEvent event,
    final Emitter<HabitState> emit,
  ) async {
    emit(state.copyWith(message: '', status: HabitStateStatus.loading));

    final habitOrFailure =
        await deleteHabit(DeleteHabitParams(habit: event.habit));

    habitOrFailure.fold(
      (habit) => emit(state.copyWith(
        habit: habit,
        message: '',
        status: HabitStateStatus.deleteSuccess,
      )),
      (failure) => emit(state.copyWith(
        message: failure.message,
        status: HabitStateStatus.deleteFailed,
      )),
    );
  }

  Future<void> _onCompleteHabit(
    final CompleteHabitEvent event,
    final Emitter<HabitState> emit,
  ) async {
    emit(state.copyWith(message: '', status: HabitStateStatus.loading));

    final int currentDate = DateTime.now().millisecondsSinceEpoch;
    final List<int> doneDates = [...event.habit.doneDates, currentDate];
    doneDates.sort();

    final habitOrFailure = await updateHabit(UpdateHabitParams(
      oldHabit: event.habit,
      doneDates: doneDates,
    ));

    habitOrFailure.fold(
      (habit) {
        final List<int> interval = Utils.intervalFor(habit.frequency);
        final int completeCount = habit.doneDates
                .where((final int date) =>
                    date > interval.first &&
                    date < interval.last &&
                    date != currentDate)
                .length +
            1;

        completeCount < habit.count
            ? emit(state.copyWith(
                habit: habit,
                message: '',
                status: HabitStateStatus.canDoMore,
                snackBarMessage: habit.type == HabitType.good
                    ? 'You should do this ${habit.count - completeCount} times more'
                    : 'You can do this ${habit.count - completeCount} times more',
              ))
            : emit(state.copyWith(
                habit: habit,
                message: '',
                status: HabitStateStatus.cantDoMore,
                snackBarMessage: habit.type == HabitType.good
                    ? Constants.textBreathtaking
                    : Constants.textStop,
              ));
      },
      (failure) => emit(state.copyWith(
        message: failure.message,
        status: HabitStateStatus.completeFailed,
      )),
    );
  }
}
