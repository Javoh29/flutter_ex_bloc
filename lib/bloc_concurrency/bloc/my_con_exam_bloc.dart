import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_con_exam_event.dart';
part 'my_con_exam_state.dart';

class MyConExamBloc extends Bloc<MyConExamEvent, MyConExamState> {
  MyConExamBloc() : super(MyConExamInitial()) {
    on<LoadDataEvent>(
      _loadData,
      transformer: restartable(),
    );
  }

  Future<void> _loadData(
    LoadDataEvent event,
    Emitter<MyConExamState> emit,
  ) async {
    DateTime start = DateTime.now();
    emit(
      MyConExamLoading(
        data: 'Start Time: ${start.toString()}',
      ),
    );
    try {
      await Future.delayed(const Duration(seconds: 4));
      DateTime end = DateTime.now();
      emit(
        MyConExamLoaded(
          "Data loaded successfully:\nStart Time: ${start.toString()}\nEnd Time: ${end.toString()}\nTime taken: ${end.difference(start).inMilliseconds} ms",
        ),
      );
    } catch (e) {
      emit(MyConExamError(e.toString()));
    }
  }
}
