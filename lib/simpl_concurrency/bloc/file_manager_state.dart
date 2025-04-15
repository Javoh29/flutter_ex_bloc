part of 'file_manager_bloc.dart';

@immutable
sealed class FileManagerState {
  final List<FileModel> files;

  const FileManagerState({
    this.files = const <FileModel>[],
  });
}

final class FileManagerInitial extends FileManagerState {}

final class FileManagerLoading extends FileManagerState {
  const FileManagerLoading({
    required super.files,
  });
}

final class FileManagerLoaded extends FileManagerState {
  const FileManagerLoaded({
    required super.files,
  });
}

final class FileManagerError extends FileManagerState {
  final String error;

  const FileManagerError({
    required this.error,
    super.files,
  });
}
