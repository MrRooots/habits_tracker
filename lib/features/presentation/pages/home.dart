import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:habits_tracker/service_locator.dart';

import 'package:habits_tracker/core/themes/palette.dart';

import 'package:habits_tracker/features/domain/entities/habit_entity.dart';

import 'package:habits_tracker/features/presentation/bloc/habit/habit_bloc.dart';
import 'package:habits_tracker/features/presentation/bloc/habits_list/habits_list_bloc.dart';

import 'package:habits_tracker/features/presentation/pages/create_habit/habit_form.dart';
import 'package:habits_tracker/features/presentation/pages/habits_list/habits_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                indicatorWeight: 4.0,
                indicatorColor: Palette.lightGreenSalad,
                indicatorPadding: EdgeInsets.symmetric(horizontal: -16.0),
                tabs: [
                  Tab(child: Text('Good', style: TextStyle(fontSize: 16.0))),
                  Tab(child: Text('Bad', style: TextStyle(fontSize: 16.0))),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (context) => sl<HabitsListBloc>()
                ..add(const ReadAllHabitsEvent(type: HabitType.good)),
              child: const HabitsListPage(habitType: HabitType.good),
            ),
            BlocProvider(
              create: (context) => sl<HabitsListBloc>()
                ..add(const ReadAllHabitsEvent(type: HabitType.bad)),
              child: const HabitsListPage(habitType: HabitType.bad),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 55),
          child: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider<HabitBloc>.value(
                value: BlocProvider.of<HabitBloc>(context),
                child: const HabitFormPage(),
              ),
            )),
            tooltip: 'Create habit',
            child: const ImageIcon(
              AssetImage('assets/images/add_circle.png'),
              size: 64.0,
            ),
          ),
        ),
      ),
    );
  }
}
