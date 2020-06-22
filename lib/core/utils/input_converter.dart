import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUInt(String numString) {
    try {
      int parsedInt = int.parse(numString);
      if (parsedInt < 0) {
        throw FormatException();
      }
      return Right(parsedInt);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => [];
}
