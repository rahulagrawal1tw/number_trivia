import 'package:get_it/get_it.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_new_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

////new class

final sLocator = GetIt.instance;

Future<void> init() async {
  ///! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sLocator.registerLazySingleton(() => sharedPreferences);
  sLocator.registerLazySingleton(() => http.Client());

  // Ensure DataConnectionChecker is registered
  sLocator.registerLazySingleton(() => DataConnectionChecker());

  ///! Features - Number Trivia
  //Bloc
  sLocator.registerFactory(() => NumberTriviaNewBloc(
      getConcreteNumberTrivia: sLocator(),
      getRandomNumberTrivia: sLocator(),
      inputConverter: sLocator()));

  //Use cases
  sLocator.registerLazySingleton(() => GetConcreteNumberTrivia(sLocator()));
  sLocator.registerLazySingleton(() => GetRandomNumberTrivia(sLocator()));

  //Repository
  sLocator.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          remoteDataSource: sLocator(),
          localDataSource: sLocator(),
          networkInfo: sLocator()));

  // Data Sources
  sLocator.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sLocator()));

  sLocator.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sLocator()));

  ///! Core
  sLocator.registerLazySingleton(() => InputConverter());
  sLocator
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sLocator()));
}
