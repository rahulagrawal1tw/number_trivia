import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';
import 'number_trivia_event.dart';
import 'number_trivia_state.dart';


const String serverFailureMessage = "Server Failure";
const String cacheFailureMessage = "Cache Failure";
const String invalidInputFailureMessage =
    "Invalid input- Please input only positive integer";

class NumberTriviaNewBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaNewBloc({
    @required this.getConcreteNumberTrivia,
    @required this.getRandomNumberTrivia,
    @required this.inputConverter,
  }) : super(Empty()){
    on<GetTriviaForConcreteNumber>(getTriviaForConcreteNumberEventFunction);
    on<GetTriviaForRandomNumber>(getTriviaForRandomNumberEventFunction);
  }

  FutureOr<void> getTriviaForConcreteNumberEventFunction(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async{
    final inputEither =
    inputConverter.stringToUnsignedInteger(event.numberString);

    await inputEither.fold((failure) async {
      emit(
        Error(message: invalidInputFailureMessage),
      );
    }, (integer) async {
      emit(Empty());
      emit(Loading());
      final failureOrTrivia =
      await getConcreteNumberTrivia(Params(number: integer));
      await failureOrTrivia.fold(
            (failure) async {
          emit(Error(message: _mapFailureToMessage(failure)));
        },
            (trivia) async{
          emit(Loaded(numberTrivia: trivia));
        },
      );
    });
  }

  FutureOr<void> getTriviaForRandomNumberEventFunction(
      GetTriviaForRandomNumber event,
      Emitter<NumberTriviaState> emit) async {

    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    failureOrTrivia.fold(
          (failure) async {
        emit(Error(message: _mapFailureToMessage(failure)));
      },
          (trivia) async {
        emit(Loaded(numberTrivia: trivia));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}