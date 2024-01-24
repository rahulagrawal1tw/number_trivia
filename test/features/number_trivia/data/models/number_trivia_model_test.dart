import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test");

  test('should be a subclass of NumberTriviaModel', () async {
    //arrange

    //act

    //assert
    expect(tNumberTriviaModel, isA<NumberTriviaModel>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, isA<NumberTriviaModel>());
    });
  });

  test(
    'should return a valid model when the JSON number is regarded as a double',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert
      expect(result, isA<NumberTriviaModel>());
    },
  );

  test('should return a json map when containing proper data', () async {
    //arrange

    //act
    final result = tNumberTriviaModel.toJson();
    //assert

    final expectedMap = {
      "text": "Test",
      "number": 1,
    };

    expect(result, expectedMap);
  });
}
