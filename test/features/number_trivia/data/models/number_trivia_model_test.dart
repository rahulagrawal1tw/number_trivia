import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test");

  test('should be a subclass of NumberTriviaModel', () async {
    //arrange

    //act

    //assert
    expect(tNumberTriviaModel, isA<NumberTriviaModel>());
  });
}
