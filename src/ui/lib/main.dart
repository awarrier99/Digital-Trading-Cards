import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/CardInfo.dart';

import 'package:ui/screens/WelcomeScreen.dart';
import 'palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => CardInfoModel(),
      child: MaterialApp(
        title: 'Wisteria',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Palette.primaryGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WelcomeScreen(title: 'Wisteria.')
      )
    );
  }
}
