import 'package:flutter/material.dart';

import '../palette.dart';
import 'CreateCard1.dart';


class Home extends StatelessWidget {
  Future createCard(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCard1()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SizedBox(
            child: RaisedButton(
                child: Text('Create Card'),
                textColor: Colors.white,
                color: Palette.primaryGreen,
                onPressed: () {
                  createCard(context);
                }
            )
        )
      )
    );
  }
}