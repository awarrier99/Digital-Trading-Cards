import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/RouteGenerator.dart';
import 'package:ui/models/Global.dart';

import 'palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalModel>(
      create: (context) => GlobalModel(navigatorKey),
      child: MaterialApp(
        title: 'Wisteria',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Palette.primaryGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
