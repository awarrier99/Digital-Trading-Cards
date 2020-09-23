import 'package:flutter/material.dart';

class SubFormInheritedWidget extends InheritedWidget {
  const SubFormInheritedWidget({
    Key key,
    @required this.inputBuilder,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Function inputBuilder;

  static SubFormInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SubFormInheritedWidget>();
  }

  @override
  bool updateShouldNotify(SubFormInheritedWidget old) => child != old.child;
}
