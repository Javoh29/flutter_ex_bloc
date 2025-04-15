import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex_bloc/simpl_concurrency/bloc/file_manager_bloc.dart';
import 'package:flutter_ex_bloc/simpl_concurrency/statuses.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FileManagerBloc>(
      create: (context) => FileManagerBloc()
        ..add(
          GetFilesEvent(20),
        ),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<FileManagerBloc, FileManagerState>(
            builder: (context, state) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                itemBuilder: (context, index) {
                  final file = state.files[index];
                  return ListTile(
                    tileColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      'File ID: ${file.id}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      'Status: ${file.status.name}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: _trailingIcon(file.status),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: state.files.length,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _trailingIcon(Statuses status) {
    switch (status) {
      case Statuses.success:
        return const Icon(
          Icons.check_circle,
          size: 24,
          color: Colors.green,
        );
      case Statuses.error:
        return const Icon(
          Icons.error,
          size: 24,
          color: Colors.red,
        );
      default:
        return SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
    }
  }
}
