import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/platform/network_info.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_app/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = NumberTriviaRepositoryImpl(
      numberTriviaRemoteDataSource: mockRemoteDataSource,
      numberTriviaLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
