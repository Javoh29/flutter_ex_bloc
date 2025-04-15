import 'dart:async';

import 'package:flutter_ex_bloc/simpl_bloc/simpl_base_bloc.dart';

abstract class SimplBloc<Event, State> extends SimplBaseBloc<State> {
  final _eventStream = StreamController<Event>();

  SimplBloc(super.state) {
    _eventStream.stream.listen(listener);
  }

  void listener(Event event);

  void add(Event event) {
    _eventStream.add(event);
  }

  @override
  void close() {
    _eventStream.close();
  }
}
