import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/domain/usecases/read_all_habits.dart';

part 'habits_list_event.dart';
part 'habits_list_state.dart';

class HabitsListBloc extends Bloc<HabitsListEvent, HabitsListState> {
  ReadAllHabitsUseCase readAllHabits;

  HabitsListBloc({
    required this.readAllHabits,
  }) : super(const HabitsListState()) {
    on<ReadAllHabitsEvent>(_onReadAllHabits);
  }

  Future<void> _onReadAllHabits(
    final ReadAllHabitsEvent event,
    final Emitter<HabitsListState> emit,
  ) async {
    emit(state.copyWith(status: HabitsStateStatus.loading));

    final failureOrHabits = await readAllHabits(ReadAllHabitsParams(
      type: event.type,
      sortByDate: event.sortByDate,
      query: event.query,
    ));

    failureOrHabits.fold(
      (habits) => emit(state.copyWith(
        habits: habits,
        message: '',
        status: HabitsStateStatus.success,
      )),
      (failure) => emit(state.copyWith(
        habits: [],
        message: '${failure.code}\n${failure.message}',
        status: HabitsStateStatus.failed,
      )),
    );
  }
}
