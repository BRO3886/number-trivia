import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia_app/core/error/exceptions.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import '../../domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<NumberTrivia> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<NumberTrivia> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTrivia> getConcreteNumberTrivia(int number) =>
      _getTrivia("http://numbersapi.com/$number");

  @override
  Future<NumberTrivia> getRandomNumberTrivia() =>
      _getTrivia("http://numbersapi.com/random");

  Future<NumberTrivia> _getTrivia(String url) async {
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final NumberTriviaModel model = NumberTriviaModel.fromJson(
        jsonDecode(
          utf8.decode(response.bodyBytes),
        ),
      );
      return model;
    } else {
      throw ServerException();
    }
  }
}
