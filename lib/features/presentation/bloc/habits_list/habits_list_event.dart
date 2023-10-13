part of 'habits_list_bloc.dart';

sealed class HabitsListEvent extends Equatable {
  const HabitsListEvent();
}

final class ReadAllHabitsEvent extends HabitsListEvent {
  final HabitType type;
  final bool sortByDate;
  final String query;

  const ReadAllHabitsEvent({
    this.type = HabitType.good,
    this.sortByDate = false,
    this.query = '',
  });

  @override
  List<Object> get props => [type, sortByDate, query];
}
