import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/utils/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringtoUInt', () {
    test(
      'should return a uint when valid number string is passed',
      () async {
        //arrange
        final str = '134';
        //act
        final result = inputConverter.stringToUInt(str);
        //assert
        expect(result, Right(134));
      },
    );

    test(
      'should return a failure when invalid number string is passed',
      () async {
        //arrange
        final str = 'abc';
        //act
        final result = inputConverter.stringToUInt(str);
        //assert
        expect(result, Left(InvalidInputFailure()));
      },
    );

    test(
      'should return a failure when negative integer is detected',
      () async {
        //arrange
        final str = '-123';
        //act
        final result = inputConverter.stringToUInt(str);
        //assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
