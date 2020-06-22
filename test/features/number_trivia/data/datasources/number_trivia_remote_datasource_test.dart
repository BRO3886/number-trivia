import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import 'package:number_trivia_app/core/error/exceptions.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl remoteDataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl =
        NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void httpClientSendSuccess() {
    when(
      mockHttpClient.get(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      ),
    ).thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void httpClientSendFailure() {
    when(
      mockHttpClient.get(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      ),
    ).thenAnswer((_) async => http.Response('something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture('trivia.json')));

    test(
      'should perform a GET request on a URL with $tNumber as endpoint and application/json header',
      () async {
        //arrange
        httpClientSendSuccess();
        //act
        remoteDataSourceImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(
          mockHttpClient.get(
            'http://numbersapi.com/$tNumber',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          ),
        );
      },
    );

    test(
      'should return a NumberTrivia when the response code is 200',
      () async {
        //arrange
        httpClientSendSuccess();
        //act
        final result =
            await remoteDataSourceImpl.getConcreteNumberTrivia(tNumber);
        //assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when response code is 404 or other',
      () async {
        //arrange
        httpClientSendFailure();
        //act
        final call = remoteDataSourceImpl.getConcreteNumberTrivia;
        //assert
        expect(() => call(tNumber), throwsA(isA<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    // final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture('trivia.json')));

    test(
      'should perform a GET request on a URL with a random number as endpoint and application/json header',
      () async {
        //arrange
        httpClientSendSuccess();
        //act
        remoteDataSourceImpl.getRandomNumberTrivia();
        //assert
        verify(
          mockHttpClient.get(
            'http://numbersapi.com/random',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          ),
        );
      },
    );

    test(
      'should return a NumberTrivia when the response code is 200',
      () async {
        //arrange
        httpClientSendSuccess();
        //act
        final result = await remoteDataSourceImpl.getRandomNumberTrivia();
        ;
        //assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when response code is 404 or other',
      () async {
        //arrange
        httpClientSendFailure();
        //act
        final call = remoteDataSourceImpl.getRandomNumberTrivia;
        //assert
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });
}
