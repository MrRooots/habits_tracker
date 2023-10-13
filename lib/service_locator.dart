import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/services/network_info.dart';

import 'package:habits_tracker/features/domain/usecases/create_habit.dart';
import 'package:habits_tracker/features/domain/usecases/delete_habit.dart';
import 'package:habits_tracker/features/domain/usecases/update_habit.dart';

import 'package:habits_tracker/core/services/hive_manager.dart';
import 'package:habits_tracker/core/services/session.dart';

import 'package:habits_tracker/features/data/repositories/repository_impl.dart';
import 'package:habits_tracker/features/domain/usecases/read_all_habits.dart';

import 'package:habits_tracker/features/data/datasources/local_data_source.dart';
import 'package:habits_tracker/features/data/datasources/remote_data_source.dart';
import 'package:habits_tracker/features/domain/repositories/repository.dart';

import 'package:habits_tracker/features/presentation/bloc/habit/habit_bloc.dart';
import 'package:habits_tracker/features/presentation/bloc/habits_list/habits_list_bloc.dart';

final GetIt sl = GetIt.instance;

/// Register all BLoC's
void registerBLoC() {
  sl.registerFactory(() => HabitBloc(
        createHabit: sl(),
        updateHabit: sl(),
        deleteHabit: sl(),
      ));

  sl.registerFactory(() => HabitsListBloc(
        readAllHabits: sl(),
      ));
}

/// Register use cases
void registerUseCases() {
  sl.registerLazySingleton(() => ReadAllHabitsUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateHabitUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateHabitUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteHabitUseCase(repository: sl()));
}

/// Register repositories
void registerRepositories() {
  sl.registerLazySingleton<HabitRepository>(
    () => HabitRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
}

/// Register data sources
void registerDataSources() {
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(session: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(hiveManager: sl()),
  );
}

/// Register core services
Future<void> registerCoreServices() async {
  sl.registerLazySingleton<Session>(() => SessionImpl());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(sl()));

  sl.registerLazySingleton(() => HiveManager.instance);

  sl.registerLazySingleton(() => InternetConnectionChecker());
}

/// Initialize all application internal dependencies
void initializeDependencies() {
  // BLoCs
  registerBLoC();

  // Usecases
  registerUseCases();

  // Repositories
  registerRepositories();

  // Data sources
  registerDataSources();

  // Core and services
  registerCoreServices();
}
