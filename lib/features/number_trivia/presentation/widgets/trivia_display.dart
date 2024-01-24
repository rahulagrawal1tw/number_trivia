import 'package:flutter/cupertino.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  TriviaDisplay({Key key, @required this.numberTrivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Third of the size of the screen
      height: MediaQuery.of(context).size.height / 3,
      child: Column(children: <Widget>[
        Text(
          numberTrivia.number.toString(),
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Text(
                numberTrivia.text,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
