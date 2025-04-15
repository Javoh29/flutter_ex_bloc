import 'package:flutter/material.dart';

class SimplInherited<B> extends InheritedWidget {
  const SimplInherited({
    required this.bloc,
    required super.child,
    super.key,
  });

  final B bloc;

  static B read<B>(BuildContext context, {bool listen = false}) {
    if (listen) {
      final SimplInherited<B>? widget =
          context.dependOnInheritedWidgetOfExactType<SimplInherited<B>>();
      assert(widget != null, 'Не найден SimplInherited<$B> в дереве');
      return widget!.bloc;
    } else {
      final SimplInherited<B>? widget =
          context.findAncestorWidgetOfExactType<SimplInherited<B>>();
      assert(widget != null, 'Не найден SimplInherited<$B> в дереве');
      return widget!.bloc;
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
