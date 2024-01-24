import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Container(
        child: SingleChildScrollView(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
