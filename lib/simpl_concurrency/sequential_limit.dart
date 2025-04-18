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
      int limit2 = limit;
      if (listEvents.length <= limit) {
        limit2 = listEvents.length;
      }
      for (int i = 0; i < limit2; i++) {
        final E evenT = listEvents.removeFirst();
        count++;
        mapper(evenT).listen(
          null,
          onDone: () {
            count--;
            processEvent();
          },
          onError: controller.addError,
        );
      }
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

// import 'dart:async';
// import 'dart:collection';

// import 'package:flutter_bloc/flutter_bloc.dart';

// /// Трансформер, ограничивающий количество одновременно (конкурентно) обрабатываемых событий.
// /// [limit] – максимальное число одновременно обрабатываемых событий.
// EventTransformer<E> sequentialLimit<E>(int limit) {
//   return (events, mapper) {
//     // Контроллер для выдачи результирующего потока
//     final controller = StreamController<E>(sync: true);

//     // Очередь для накопления входящих событий
//     final queue = Queue<E>();

//     // Счётчик активных (обрабатывающихся прямо сейчас) событий
//     int active = 0;

//     // Флаг, показывающий, что поток событий (events) завершён,
//     // и новых событий больше не поступит
//     bool inputDone = false;

//     // Подписка на основной поток событий
//     late final StreamSubscription<E> subscription;
//     void tryClose() {
//       if (inputDone && active == 0 && queue.isEmpty) {
//         controller.close();
//       }
//     }

//     // Запускает обработку событий из очереди, если есть свободные «слоты»
//     void tryProcess() {
//       // Пока число активных обработок меньше лимита и очередь не пуста
//       while (active < limit && queue.isNotEmpty) {
//         final event = queue.removeFirst();
//         active++;

//         // Подключаемся к результату mapper(event),
//         // чтобы в onDone понимать, когда обработка завершится
//         mapper(event).listen(
//           // Передаём результат обработки дальше
//           controller.add,
//           // Если в маппере произошла ошибка, пробрасываем её выше
//           onError: controller.addError,
//           // Когда обработка одного события завершена,
//           // уменьшаем счётчик и пытаемся запустить следующую
//           onDone: () {
//             active--;
//             tryProcess();
//             tryClose();
//           },
//         );
//       }
//     }

//     // Проверяет, нужно ли завершить controller, когда
//     // новых событий уже не будет, а все запущенные – отработали

//     // Осуществляем подписку на входные события
//     subscription = events.listen(
//       (event) {
//         // Кладём событие в очередь
//         queue.addLast(event);
//         // И пытаемся обработать при наличии свободных «слотов»
//         tryProcess();
//       },
//       onError: controller.addError,
//       onDone: () {
//         // Ставим флаг о том, что новых событий больше не будет
//         inputDone = true;
//         // Могли ли остаться события в очереди или в активной обработке?
//         // Если нет – закрываем; если да – закроется автоматически, когда всё доедет
//         tryClose();
//       },
//     );

//     // Логика на случай, если кто-то заPause-ит результат или отменит подписку
//     controller.onListen = () {
//       // Дополнительно можно что-то выполнить при onListen
//     };
//     controller.onPause = () => subscription.pause();
//     controller.onResume = () => subscription.resume();
//     controller.onCancel = () => subscription.cancel();

//     return controller.stream;
//   };
// }
