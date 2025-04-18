import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex_bloc/simpl_concurrency/models/file_model.dart';
import 'package:flutter_ex_bloc/simpl_concurrency/sequential_limit.dart';
import 'package:flutter_ex_bloc/simpl_concurrency/statuses.dart';

part 'file_manager_event.dart';
part 'file_manager_state.dart';

class FileManagerBloc extends Bloc<FileManagerEvent, FileManagerState> {
  List<FileModel> files = [];
  FileManagerBloc() : super(FileManagerInitial()) {
    on<GetFilesEvent>(_getFiles);
    on<SendFileEvent>(
      _sendFile,
      transformer: sequentialLimit(4),
    );
  }

  Future<void> _sendFile(
    SendFileEvent event,
    Emitter<FileManagerState> emit,
  ) async {
    files.add(
      event.model.copyWith(
        status: Statuses.loading,
      ),
    );
    emit(FileManagerLoading(files: files));
    try {
      await Future.delayed(const Duration(seconds: 3));
      files = files.map(
        (e) {
          if (e.id == event.model.id) {
            return e.copyWith(
              status: Statuses.success,
            );
          }
          return e;
        },
      ).toList();
      emit(FileManagerLoaded(files: files));
    } catch (e) {
      files = files.map(
        (e) {
          if (e.id == event.model.id) {
            return e.copyWith(
              status: Statuses.error,
            );
          }
          return e;
        },
      ).toList();
      emit(
        FileManagerError(
          error: e.toString(),
          files: files,
        ),
      );
    }
  }

  FutureOr<void> _getFiles(
    GetFilesEvent event,
    Emitter<FileManagerState> emit,
  ) async {
    for (var i = 0; i < event.count; i++) {
      await Future.delayed(
        const Duration(milliseconds: 10),
      );
      final dateTime = DateTime.now().millisecondsSinceEpoch;
      add(
        SendFileEvent(
          FileModel(
            id: dateTime,
            status: Statuses.initial,
          ),
        ),
      );
    }
  }
}
