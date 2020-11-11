import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:ui/palette.dart';
import '../components/RoundedButton.dart';

// UI screen for adding a card of another user by NFC

class AddCardByNFC extends StatefulWidget {
  @override
  _AddCardByNFCState createState() => _AddCardByNFCState();
}

class _AddCardByNFCState extends State<AddCardByNFC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Card By NFC Tap',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('lib/assets/images/addCardByNFC.png'),
              SizedBox(height: 20),
              Text(
                'Searching for Card',
                style: TextStyle(
                  color: Palette.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(),
              SizedBox(height: 30),
              RoundedButton(
                'Cancel',
                Palette.secondary,
                () {
                  Navigator.pop(context);
                },
                false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
