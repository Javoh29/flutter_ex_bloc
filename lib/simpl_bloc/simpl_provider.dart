import 'package:flutter/material.dart';
import 'package:flutter_ex_bloc/simpl_bloc/simpl_inherited.dart';

class SimplProvider<B> extends StatefulWidget {
  const SimplProvider({
    required this.create,
    required this.child,
    super.key,
  });
  final B Function() create;
  final Widget child;

  @override
  State<SimplProvider<B>> createState() => _SimplProviderState<B>();
}

class _SimplProviderState<B> extends State<SimplProvider<B>> {
  late final B _bloc;
  
  @override
  void initState() {
    super.initState();
    _bloc = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return SimplInherited<B>(
      bloc: _bloc,
      child: widget.child,
    );
  }
}
