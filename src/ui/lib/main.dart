import 'package:flutter/material.dart';

import 'package:ui/screens/WelcomeScreen.dart';
import 'palette.dart';

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
        primaryColor: Palette.primaryGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(title: 'Wisteria.'),
    );
  }
}
