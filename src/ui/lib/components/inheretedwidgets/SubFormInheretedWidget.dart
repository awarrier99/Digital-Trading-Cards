import 'package:flutter/material.dart';

class SubFormInheretedWidget extends InheritedWidget {
  const SubFormInheretedWidget({
    Key key,
    @required this.inputs,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Widget inputs;

  static SubFormInheretedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SubFormInheretedWidget>();
  }

  @override
  bool updateShouldNotify(SubFormInheretedWidget old) => child != old.child;
}
