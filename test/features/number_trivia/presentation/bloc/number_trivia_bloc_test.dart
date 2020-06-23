import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/utils/input_converter.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia getConcreteNumberTrivia;
  MockGetRandomNumberTrivia getRandomNumberTrivia;
  MockInputConverter inputConverter;

  setUp(() {
    getConcreteNumberTrivia = MockGetConcreteNumberTrivia();

    getRandomNumberTrivia = MockGetRandomNumberTrivia();

    inputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: getConcreteNumberTrivia,
      getRandomNumberTrivia: getRandomNumberTrivia,
      inputConverter: inputConverter,
    );
  });

  test('init state should be empty', () async {
    //assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('getTriviaConcrete', () {
    final tNumberParsed = 1;
    final tNumberString = "1";
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test text');

    test(
      'should call input converter to validate and convert a string to an unsigned int',
      () async {
        //arrange
        when(inputConverter.stringToUInt(any)).thenReturn(Right(tNumberParsed));
        //act
        bloc.add(GetNumberTriviaConcrete(numberString: tNumberString));
        await untilCalled(inputConverter.stringToUInt(any));
        //assert
        verify(inputConverter.stringToUInt(tNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        //arrange
        when(inputConverter.stringToUInt(any))
            .thenReturn(Left(InvalidInputFailure()));
        //act
        bloc.add(GetNumberTriviaConcrete(numberString: tNumberString));
        //assert
        final expected = [
          Empty(),
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
        //act
        bloc.add(GetNumberTriviaConcrete(numberString: tNumberString));
      },
    );
  });
}
