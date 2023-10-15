import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:habits_tracker/core/themes/palette.dart';

import 'package:habits_tracker/features/domain/entities/habit_entity.dart';

import 'package:habits_tracker/features/presentation/bloc/habit/habit_bloc.dart';
import 'package:habits_tracker/features/presentation/bloc/habits_list/habits_list_bloc.dart';
import 'package:habits_tracker/features/presentation/pages/habits_list/components/empty_placeholder.dart';

import 'package:habits_tracker/features/presentation/pages/habits_list/components/habit_card.dart';
import 'package:habits_tracker/features/presentation/pages/habits_list/components/loading_error_placeholder.dart';

import 'package:habits_tracker/features/presentation/widgets/bottom_search_sheet.dart';
import 'package:habits_tracker/features/presentation/widgets/custom_snack_bar.dart';

class HabitsListPage extends StatefulWidget {
  final HabitType habitType;
  const HabitsListPage({super.key, required this.habitType});

  @override
  State<HabitsListPage> createState() => _HabitsListPageState();
}

class _HabitsListPageState extends State<HabitsListPage>
    with AutomaticKeepAliveClientMixin {
  String query = '';
  bool sortByDate = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: BlocListener<HabitBloc, HabitState>(
        listenWhen: (previous, current) => previous.isLoading,
        listener: (context, state) {
          if (state.habit?.type != widget.habitType && !state.isEditSuccess) {
            return;
          } else if (state.isSuccess) {
            BlocProvider.of<HabitsListBloc>(context).add(ReadAllHabitsEvent(
              type: widget.habitType,
              sortByDate: sortByDate,
              query: query,
            ));
          } else if (state.isDeleteFailed) {
            CustomSnackBar.showError(
                context, 'Failed to delete habit\n${state.message}');
          } else if (state.isCompleteFailed) {
            CustomSnackBar.showError(
                context, 'Failed to complete habit\n${state.message}');
          }

          //! We neaed to check HabitType to avoid duplicate snackbars on both tabs
          if (state.habit?.type == widget.habitType && state.isSuccess) {
            if (state.isDeleteSuccess) {
              CustomSnackBar.showSuccess(context, 'Habit Deleted!');
            } else if (state.isCreateSuccess || state.isEditSuccess) {
              CustomSnackBar.showSuccess(context, 'Habit Saved!');
            } else if (state.isCantDoMore) {
              widget.habitType == HabitType.good
                  ? CustomSnackBar.showSuccess(context, state.snackBarMessage)
                  : CustomSnackBar.showError(context, state.snackBarMessage);
            } else if (state.isCanDoMore) {
              CustomSnackBar.showInfo(context, state.snackBarMessage);
            }
          }
        },
        child: BlocBuilder<HabitsListBloc, HabitsListState>(
          builder: (context, state) {
            print(state);
            if (state.isLoading) {
              return const Center(
                child: SpinKitSpinningLines(color: Palette.lightGreenSalad),
              );
            } else if (state.isSuccess) {
              if (state.habits.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 60.0, top: 8.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.habits.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HabitCard(habit: state.habits[index]);
                    },
                  ),
                );
              } else {
                return const EmptyPlaceholder();
              }
            } else if (state.isFailed) {
              return LoadingErrorPlaceholder(message: state.message);
            }
            return Container();
          },
        ),
      ),
      bottomSheet: BottomSearchSheet(
        habitType: widget.habitType,
        onSortByDateChange: onSortByDateChange,
        onFilterQueryChange: onFilterQueryChange,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  /// Callback for [BottomSearchSheet] to perserve state in list
  /// for example after sorting and adding\editing new habits
  void onSortByDateChange(final bool val) => sortByDate = val;

  /// Callback for [BottomSearchSheet] to perserve state in list
  /// for example after filtering and adding\editing new habits
  void onFilterQueryChange(final String val) => query = val;
}
