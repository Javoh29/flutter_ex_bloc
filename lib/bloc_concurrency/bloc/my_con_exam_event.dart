part of 'my_con_exam_bloc.dart';

@immutable
sealed class MyConExamEvent {
  const MyConExamEvent();
}

class LoadDataEvent extends MyConExamEvent {
  const LoadDataEvent();
}
