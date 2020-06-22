part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}

class GetNumberTriviaConcrete extends NumberTriviaEvent {
  final String numberString;

  GetNumberTriviaConcrete({@required this.numberString});
  @override
  List<Object> get props => [numberString];
}

class GetNumberTriviaRandom extends NumberTriviaEvent {
  @override
  List<Object> get props => [];
}
