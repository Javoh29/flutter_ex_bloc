import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ex_bloc/simpl_bloc/simpl_base_bloc.dart';
import 'package:flutter_ex_bloc/simpl_bloc/simpl_inherited.dart';

class SimplBlocListener<B extends SimplBaseBloc<S>, S> extends StatefulWidget {
  const SimplBlocListener({
    required this.child,
    required this.listener,
    this.listenWhen,
    super.key,
  });
  final void Function(BuildContext context, S state) listener;
  final bool Function(S previous, S current)? listenWhen;
  final Widget child;

  @override
  State<SimplBlocListener<B, S>> createState() =>
      _SimplBlocListenerState<B, S>();
}

class _SimplBlocListenerState<B extends SimplBaseBloc<S>, S>
    extends State<SimplBlocListener<B, S>> {
  late S _previousState;
  late final StreamSubscription<S> _subscription;

  @override
  void initState() {
    super.initState();
    final bloc = SimplInherited.read<B>(context);
    _previousState = bloc.state;
    _subscription = bloc.stateStream.listen(_listener);
  }

  void _listener(S state) {
    bool isUpdate = true;
    if (widget.listenWhen != null) {
      isUpdate = widget.listenWhen?.call(_previousState, state) ?? true;
    }
    if (isUpdate) {
      widget.listener(context, state);
    }
    _previousState = state;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
