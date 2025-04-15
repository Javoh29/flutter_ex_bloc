import 'dart:async';

abstract class SimplBaseBloc<State> {
  SimplBaseBloc(this.state) {
    _stateStream.add(state);
  }
  final _stateStream = StreamController<State>.broadcast();
  State state;

  Stream<State> get stateStream => _stateStream.stream;

  void emit(State value) {
    state = value;
    _stateStream.add(value);
  }

  void close() {
    _stateStream.close();
  }
}
