import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:habits_tracker/service_locator.dart';

import 'package:habits_tracker/core/themes/theme.dart';

import 'package:habits_tracker/features/presentation/bloc/habit/habit_bloc.dart';
import 'package:habits_tracker/features/presentation/pages/home.dart';
import 'package:habits_tracker/features/presentation/widgets/my_scroll_behavior.dart';

class HabitsTrackerApp extends StatelessWidget {
  const HabitsTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.baseTheme,
      title: 'Habits Tracker',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ScrollConfiguration(
        behavior: MyScrollBehavior(),
        child: child!,
      ),
      home: BlocProvider<HabitBloc>(
        create: (_) => sl<HabitBloc>(),
        child: const HomePage(),
      ),
    );
  }
}
