part of 'file_manager_bloc.dart';

@immutable
sealed class FileManagerEvent {
  const FileManagerEvent();
}

final class SendFileEvent extends FileManagerEvent {
  final FileModel model;

  const SendFileEvent(this.model);
}

final class GetFilesEvent extends FileManagerEvent {
  final int count;
  const GetFilesEvent(this.count);
}
