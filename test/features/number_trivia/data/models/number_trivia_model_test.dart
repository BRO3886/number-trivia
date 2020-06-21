import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test text');

  test(
    'should be a subclass of number trivia entity',
    () async {
      //arrange
      //act
      //asssert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        //arrange
        Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia.json'));
        //act
        final result = NumberTriviaModel.fromJson(jsonMap);
        //assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should return a valid model when the JSON number is an double',
      () async {
        //arrange
        Map<String, dynamic> jsonMap =
            jsonDecode(fixture('trivia_double.json'));
        //act
        final result = NumberTriviaModel.fromJson(jsonMap);
        //assert
        expect(result, equals(tNumberTriviaModel));
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing proper data',
      () async {
        //act
        final result = tNumberTriviaModel.toJson();
        //assert
        final expectedMap = {
          "text": "test text",
          "number": 1,
        };
        expect(result, expectedMap);
      },
    );
  });
}
