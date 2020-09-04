import 'package:flutter/material.dart';

import 'package:ui/screens/WelcomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisteria',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF92DAAF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(title: 'Wisteria.'),
    );
  }
}
