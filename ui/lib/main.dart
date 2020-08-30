import 'package:flutter/material.dart';

import 'package:ui/CreateAccount.dart';

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
      home: WelcomeScreen(title: 'Wisteria'),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future createAccount(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateAccount()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(fontSize: 30),
            ),
            RaisedButton(
              onPressed: () {},
              textColor: Colors.white,
              color: Color(0xFF92DAAF),
              child: const Text('Sign in', style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () {
                createAccount(context);
              },
              textColor: Color(0xFF92DAAF),
              color: Colors.white,
              child: Text('Create Account', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
