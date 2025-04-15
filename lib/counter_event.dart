abstract class CounterEvent {
  const CounterEvent();
}

class IncrementCounterEvent extends CounterEvent {
  const IncrementCounterEvent(this.value);
  final int value;
}

class DecrementCounterEvent extends CounterEvent {
  const DecrementCounterEvent(this.value);
  final int value;
}
