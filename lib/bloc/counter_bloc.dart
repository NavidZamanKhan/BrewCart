import 'package:flutter_bloc/flutter_bloc.dart';

class CounterEvent {}

class CounterState {
  final int counter;
  CounterState({required this.counter});
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counter: 0));
}
