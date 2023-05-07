import 'package:get_it/get_it.dart';
import 'package:mood_tracker_2/data/datasources/days_local_datasource.dart';
import 'package:mood_tracker_2/data/datasources/settings_local_datasource.dart';
import 'package:mood_tracker_2/data/datasources/statistics_local_datasource.dart';
import 'package:mood_tracker_2/data/repository/days_repository_impl.dart';
import 'package:mood_tracker_2/data/repository/settings_repository_impl.dart';
import 'package:mood_tracker_2/data/repository/statistics_repository_impl.dart';
import 'package:mood_tracker_2/domain/repository/days_repository.dart';
import 'package:mood_tracker_2/domain/repository/settings_repository.dart';
import 'package:mood_tracker_2/domain/repository/statistics_repository.dart';
import 'package:mood_tracker_2/domain/usecases/day_usecase.dart';
import 'package:mood_tracker_2/domain/usecases/days_list_usecase.dart';
import 'package:mood_tracker_2/domain/usecases/statistics_usecase.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_edit_bloc/day_edit_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/days_list_bloc/days_list_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  /// Days
  getIt.registerFactory(() => DaysListBloc(getIt()));
  getIt.registerFactory(() => DayBloc(getIt()));

  getIt.registerLazySingleton(() => DaysListUsecase(getIt()));
  getIt.registerLazySingleton(() => DayUsecase(getIt()));

  getIt
      .registerLazySingleton<DaysRepository>(() => DaysRepositoryImpl(getIt()));
  getIt.registerLazySingleton<DaysLocalDataSource>(
      () => DaysLocalDataSourceImpl());

  /// Settings
  getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl());

  /// Statistics
  getIt.registerFactory(() => ActivitiesBloc(getIt()));
  getIt.registerFactory(() => FoodsBloc(getIt()));

  getIt.registerLazySingleton(() => StatisticsUsecase(getIt()));

  getIt.registerLazySingleton<StatisticsRepository>(
      () => StatisticsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<StatisticsLocalDataSource>(
      () => StatisticsLocalDataSourceImpl());

  /// Other
  getIt.registerFactory(() => DayEditBloc());
}
