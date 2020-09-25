import 'package:flutter/material.dart';

import '../palette.dart';

class Home extends StatelessWidget {
  Future createCard(context) async {
    Navigator.of(context).pushNamed('/createCard1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          child: SizedBox(
              child: RaisedButton(
                  child: Text('Create Card'),
                  textColor: Colors.white,
                  color: Palette.primaryGreen,
                  onPressed: () {
                    createCard(context);
                  }))),
    ));
  }
}
