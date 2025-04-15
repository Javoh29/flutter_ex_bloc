import 'package:flutter/material.dart';
import 'package:flutter_ex_bloc/simpl_bloc/simpl_base_bloc.dart';
import 'package:flutter_ex_bloc/simpl_bloc/simpl_bloc_listener.dart';
import 'package:flutter_ex_bloc/simpl_bloc/simpl_inherited.dart';

class SimplBlocBuilder<B extends SimplBaseBloc<S>, S> extends StatefulWidget {
  const SimplBlocBuilder({
    required this.builder,
    this.buildWhen,
    super.key,
  });
  final Widget Function(BuildContext context, S state) builder;
  final bool Function(S previous, S current)? buildWhen;

  @override
  State<SimplBlocBuilder<B, S>> createState() => _SimplBlocBuilderState<B, S>();
}

class _SimplBlocBuilderState<B extends SimplBaseBloc<S>, S>
    extends State<SimplBlocBuilder<B, S>> {
  late S _state;
  @override
  void initState() {
    super.initState();
    _state = SimplInherited.read<B>(context).state;
  }

  @override
  Widget build(BuildContext context) {
    return SimplBlocListener<B, S>(
      listenWhen: widget.buildWhen,
      listener: (context, state) => setState(
        () => _state = state,
      ),
      child: widget.builder(context, _state),
    );
  }
}
