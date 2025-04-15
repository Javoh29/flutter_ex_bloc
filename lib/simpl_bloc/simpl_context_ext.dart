import 'package:flutter/material.dart';
import 'package:flutter_ex_bloc/simpl_bloc/simpl_inherited.dart';

extension SimplContextExt on BuildContext {
  B getBloc<B>() {
    final SimplInherited<B>? provider =
        dependOnInheritedWidgetOfExactType<SimplInherited<B>>();
    assert(provider != null, 'No SimplProvider found in context');
    return provider!.bloc;
  }
}
