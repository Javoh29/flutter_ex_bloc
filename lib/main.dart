import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ex_bloc/bloc_concurrency/bloc/my_con_exam_bloc.dart';
import 'package:flutter_ex_bloc/counter_bloc.dart';
import 'package:flutter_ex_bloc/counter_state.dart';
import 'package:flutter_ex_bloc/simpl_bloc/simpl_bloc_builder.dart';
import 'package:flutter_ex_bloc/simpl_concurrency/app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const App(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Color(0xFFF0F2F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocConsumer<MyConExamBloc, MyConExamState>(
              listener: (context, state) {
                debugPrint(state.toString());
              },
              builder: (context, state) {
                if (state is MyConExamLoading) {
                  return const CircularProgressIndicator();
                } else if (state is MyConExamLoaded) {
                  return Text(
                    state.data,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  );
                } else if (state is MyConExamError) {
                  return Text(
                    state.error,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  );
                }
                return Text(
                  'Initial State',
                );
              },
            ),
            SimplBlocBuilder<CounterBloc, CounterState>(
              buildWhen: (previous, current) {
                return previous.count != current.count;
              },
              builder: (context, state) {
                return Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MyConExamBloc>().add(
                const LoadDataEvent(),
              );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
