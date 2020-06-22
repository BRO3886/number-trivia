import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/error/exceptions.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  NumberTriviaLocalDataSourceImpl locaLDataSourceImpl;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    locaLDataSourceImpl = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture('trivia_cache.json')));
    test(
      'should return NumberTrivia from shared prefs when there is one in cache',
      () async {
        //arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cache.json'));
        //act
        final result = await locaLDataSourceImpl.getLastNumberTrivia();
        // assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a CacheException when no cache value is present',
      () async {
        //arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        //act
        final call = locaLDataSourceImpl.getLastNumberTrivia;
        // assert
        expect(() => call(), throwsA(isA<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test text');
    test(
      'should call shared prefs to cache the data',
      () async {
        //act
        locaLDataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);
        //assert
        final jsonString = jsonEncode(tNumberTriviaModel.toJson());
        verify(mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA,
          jsonString,
        ));
      },
    );
  });
}
