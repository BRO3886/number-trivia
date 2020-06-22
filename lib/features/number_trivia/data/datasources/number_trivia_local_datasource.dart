import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:number_trivia_app/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

abstract class NumberTriviaLocalDataSource {
  ///Gets the cached [NumberTriviaModel] which was fetched last
  ///Throws [CacheException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();

  ///method to cache the number trivia
  Future cacheNumberTrivia(NumberTriviaModel model);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future cacheNumberTrivia(NumberTriviaModel model) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      jsonEncode(model.toJson()),
    );
  }
}
