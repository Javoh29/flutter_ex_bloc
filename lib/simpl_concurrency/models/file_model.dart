import 'package:flutter_ex_bloc/simpl_concurrency/statuses.dart';

class FileModel {
  final int id;
  final Statuses status;

  const FileModel({
    required this.id,
    required this.status,
  });

  FileModel copyWith({
    int? id,
    Statuses? status,
  }) {
    return FileModel(
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }
}
