import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('First Name:'),
          Text('Last Name:'),
          Text('Email:'),
          Text('Confirm Email:'),
          RaisedButton(
            onPressed: () {},
            textColor: Colors.white,
            color: Color(0xFF92DAAF),
            child: const Text('Manual Entry >', style: TextStyle(fontSize: 20)),
          ),
          RaisedButton(
            onPressed: null,
            textColor: Color(0xFF92DAAF),
            color: Colors.white,
            child: const Text('Linked In Autofill >',
                style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    ));
  }
}
