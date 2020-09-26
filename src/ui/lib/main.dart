import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/RouteGenerator.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/User.dart';
import 'palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CardInfoModel>(
          create: (context) => CardInfoModel(),
        ),
        Provider<UserModel>(create: (context) => UserModel())
      ],
      child: MaterialApp(
        title: 'Wisteria',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Palette.primaryGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
