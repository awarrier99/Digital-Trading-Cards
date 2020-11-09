import 'package:flutter/material.dart';
import '../palette.dart';

import '../components/RoundedButton.dart';

class AddCard extends StatelessWidget {
  const AddCard();

  Future addByEmail(context) async {
    Navigator.of(context).pushNamed('/addCardByEmail');
  }

  Future addByNFC(context) async {
    Navigator.of(context).pushNamed('/addCardByNFC');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Card',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('lib/assets/images/addCard.png'),
                SizedBox(height: 50),
                Text(
                  'Grow your network',
                  style: TextStyle(
                    color: Palette.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                    'Collect the cards of people you meet and build a stronger network',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.secondary,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 50),
                RoundedButton(
                  'Add by email',
                  Palette.primary,
                  () => addByEmail(context),
                  false,
                ),
                SizedBox(height: 20),
                RoundedButton(
                  'Add by NFC tap',
                  Palette.secondary,
                  () => addByNFC(context),
                  false,
                ),
              ],
            ),
          ),
        ));
  }
}
