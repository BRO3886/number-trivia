import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  ///Gets the cached [NumberTriviaModel] which was fetched last
  ///Throws [CacheException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();

  ///method to cache the number trivia  
  Future cacheNumberTrivia(NumberTriviaModel model); 
}
