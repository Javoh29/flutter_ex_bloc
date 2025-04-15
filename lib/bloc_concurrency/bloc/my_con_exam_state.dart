part of 'my_con_exam_bloc.dart';

@immutable
sealed class MyConExamState {
  const MyConExamState();
}

final class MyConExamInitial extends MyConExamState {}

final class MyConExamLoading extends MyConExamState {
  final String data;
  const MyConExamLoading({this.data = "Loading..."});
  @override
  String toString() {
    return data;
  }
}

final class MyConExamLoaded extends MyConExamState {
  final String data;

  const MyConExamLoaded(this.data);

  @override
  String toString() {
    return data;
  }
}

final class MyConExamError extends MyConExamState {
  final String error;

  const MyConExamError(this.error);
}
