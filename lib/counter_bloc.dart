import 'package:flutter_ex_bloc/counter_event.dart';
import 'package:flutter_ex_bloc/counter_state.dart';
import 'package:flutter_ex_bloc/simpl_bloc/simpl_bloc.dart';

class CounterBloc extends SimplBloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0));

  @override
  void listener(CounterEvent event) {
    switch (event) {
      case IncrementCounterEvent _:
        int count = state.count;
        count++;
        emit(CounterState(count));
        break;
      case DecrementCounterEvent _:
        var count = state.count;
        count--;
        emit(CounterState(count));
        break;
    }
  }
}
