import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_state.dart';
import '../../../../injection_container.dart';
import '../bloc/number_trivia_new_bloc.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
        ),
        body: SingleChildScrollView(child: buildBody()));
  }
}

class buildBody extends StatelessWidget {
  const buildBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sLocator<NumberTriviaNewBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              //Top half
              BlocBuilder<NumberTriviaNewBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return const MessageDisplay(
                      message: 'Start Searching',
                    );
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.numberTrivia);
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return Placeholder();
                },
              ),
              SizedBox(height: 20),
              //Bottom half
              TriviaControl()
            ],
          ),
        ),
      ),
    );
  }
}
