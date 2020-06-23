import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:number_trivia_app/core/utils/input_converter.dart';

import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const SERVER_FAILURE_MESSAGE = 'Something went wrong. Please try again later.';
const CACHE_FAILURE_MESSAGE = 'Does not exist!';
const INVALID_INPUT_FAILURE_MESSAGE = 'Please enter a valid positive integer';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required this.getConcreteNumberTrivia,
    @required this.getRandomNumberTrivia,
    @required this.inputConverter,
  });

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetNumberTriviaConcrete) {
      final numberParsed = inputConverter.stringToUInt(event.numberString);

      yield* numberParsed.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (success) async* {
          yield Loaded(numberTrivia: NumberTrivia(number: 1, text: 'test'));
        },
      );
    }
  }
}
