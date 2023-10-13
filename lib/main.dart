import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:habits_tracker/service_locator.dart';
import 'package:habits_tracker/features/internal/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// [Hive]: Initialize hive database
  await Hive.initFlutter();

  /// [ServiceLocator]: Initialize dependencies
  initializeDependencies();

  runApp(const HabitsTrackerApp());
}
