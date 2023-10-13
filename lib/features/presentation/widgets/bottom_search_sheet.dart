import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits_tracker/core/themes/palette.dart';
import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/presentation/bloc/habits_list/habits_list_bloc.dart';

class BottomSearchSheet extends StatefulWidget {
  final HabitType habitType;
  final ValueChanged<bool> onSortByDateChange;
  final ValueChanged<String> onFilterQueryChange;

  const BottomSearchSheet({
    super.key,
    required this.habitType,
    required this.onSortByDateChange,
    required this.onFilterQueryChange,
  });

  @override
  State<BottomSearchSheet> createState() => _BottomSearchSheetState();
}

class _BottomSearchSheetState extends State<BottomSearchSheet> {
  final TextEditingController _searchController = TextEditingController();

  /// Search box delay
  Timer? _timer;

  /// Serach box query
  String _searchQuery = '';

  /// Marker for date sorting
  bool _sortByDate = false;

  @override
  void dispose() {
    _searchController.dispose();
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      key: ValueKey(widget.habitType),
      backgroundColor: Palette.lightGrey,
      onClosing: () {},
      elevation: 8.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.0),
          topLeft: Radius.circular(16.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: _searchController,
            keyboardType: TextInputType.text,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            onChanged: (final String value) {
              if (_timer?.isActive ?? false) _timer!.cancel();
              _timer = Timer(const Duration(milliseconds: 300), () {
                _searchQuery = value;
                widget.onFilterQueryChange(_searchQuery);
                BlocProvider.of<HabitsListBloc>(context).add(
                  ReadAllHabitsEvent(
                    query: _searchQuery,
                    type: widget.habitType,
                    sortByDate: _sortByDate,
                  ),
                );
              });
            },
            style: const TextStyle(decoration: TextDecoration.none),
            decoration: InputDecoration(
              label: const Text('Search'),
              hintText: 'Search by title...',
              suffixIcon: IconButton(
                tooltip: _sortByDate ? 'By date' : 'By priority',
                icon: ImageIcon(
                  const AssetImage('assets/images/sort.png'),
                  size: 32.0,
                  color: _sortByDate ? Palette.lightGreenSalad : Palette.grey,
                ),
                onPressed: () {
                  setState(() => _sortByDate = !_sortByDate);
                  widget.onSortByDateChange(_sortByDate);
                  BlocProvider.of<HabitsListBloc>(context).add(
                    ReadAllHabitsEvent(
                      query: _searchQuery,
                      type: widget.habitType,
                      sortByDate: _sortByDate,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
