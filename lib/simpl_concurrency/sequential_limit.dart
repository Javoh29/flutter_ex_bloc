import 'dart:async';
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';

EventTransformer<E> sequentialLimit<E>(int limit) {
  return (events, mapper) {
    final controller = StreamController<E>();
    final listEvents = Queue<E>();
    late StreamSubscription<E> subscription;
    int count = 0;

    void processEvent() {
      if (count >= limit) {
        return;
      }
      for (int i = 0; i < limit; i++) {
        final E evenT = listEvents.removeFirst();
        count++;
        mapper(evenT).listen(
          null,
          onDone: () {
            if (count == limit) {
              count = 0;
            }
          },
          onError: controller.addError,
        );
      }
      // processEvent();
    }

    controller.onListen = () {
      subscription = events.listen(
        (event) {
          listEvents.add(event);
          processEvent();
        },
        onError: controller.addError,
        onDone: () async {
          await subscription.cancel();
          await controller.close();
        },
      );
      controller.onCancel = subscription.cancel;
    };
    return controller.stream;
  };
}
