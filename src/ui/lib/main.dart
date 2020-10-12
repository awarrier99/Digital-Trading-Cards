import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/RouteGenerator.dart';
import 'package:ui/models/Global.dart';

import 'palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<GlobalModel>(
      create: (context) => GlobalModel(),
      child: MaterialApp(
        title: 'Wisteria',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Palette.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute
      )
    );
  }
}
