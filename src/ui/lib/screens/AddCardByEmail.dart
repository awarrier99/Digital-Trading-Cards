import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/RoundedButton.dart';
import 'package:ui/palette.dart';

import '../models/CardInfo.dart';
import '../models/Global.dart';

// UI screen for adding a card of another user by email
// includes a search text input

class AddCardByEmail extends StatefulWidget {
  @override
  _AddCardByEmailState createState() => _AddCardByEmailState();
}

class _AddCardByEmailState extends State<AddCardByEmail> {
  final emailInputController = TextEditingController();
  bool _isThinking = false;

  @override
  void dispose() {
    emailInputController.dispose();
    super.dispose();
  }

  Future nextStep(CardInfo card) async {
    Navigator.of(context).pushNamed('/previewCard',
        arguments: {'cardInfo': card, 'pending': false});
  }

  void searchWithEmail() {
    setState(() {
      _isThinking = true;
    });
    if (emailInputController.text.isEmpty) {
      setState(() {
        _isThinking = false;
      });
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: 'Please enter an email',
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        backgroundColor: Color(0xffDF360E),
      )..show(context);
    } else {
      final globalModel = context.read<GlobalModel>();
      final cardInfoModel = globalModel.cardInfoModel;
      final userModel = globalModel.userModel;
      final connectionInfoModel = globalModel.connectionInfoModel;
      final userConnectionInfo = connectionInfoModel.fetchConnectionInfo(
          userModel.currentUser.id, userModel.token,
          onlyPending: false);
      cardInfoModel
          .fetchCardInfoByUsername(emailInputController.text, userModel.token)
          .then((value) {
        if (value == null) {
          setState(() {
            _isThinking = false;
          });
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            message: 'Could not find user with email \'' +
                emailInputController.text +
                '\'',
            duration: Duration(seconds: 3),
            margin: EdgeInsets.all(8),
            borderRadius: 8,
            backgroundColor: Color(0xffDF360E),
          )..show(context);
        } else if (value.user.id == userModel.currentUser.id) {
          setState(() {
            _isThinking = false;
          });
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            message: 'Oops. You cannot connect with yourself',
            duration: Duration(seconds: 3),
            margin: EdgeInsets.all(8),
            borderRadius: 8,
            backgroundColor: Color(0xffDF360E),
          )..show(context);
        } else {
          userConnectionInfo.then((connectionInfo) {
            bool alreadyConnected = false;
            for (var c in connectionInfo.connectionCards) {
              if (c.user.id == value.user.id) {
                alreadyConnected = true;
              }
            }
            if (alreadyConnected) {
              setState(() {
                _isThinking = false;
              });
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                message: 'You are already connected with this user',
                duration: Duration(seconds: 3),
                margin: EdgeInsets.all(8),
                borderRadius: 8,
                backgroundColor: Color(0xffDF360E),
              )..show(context);
            } else {
              setState(() {
                _isThinking = false;
              });
              nextStep(value);
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Card By Email',
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
              Image.asset('lib/assets/images/addCardByEmail.png'),
              SizedBox(height: 20),
              Text(
                'Enter an email',
                style: TextStyle(
                  color: Palette.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextFormField(
                  controller: emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    searchWithEmail();
                  },
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              RoundedButton(
                'Search',
                Palette.primary,
                () => searchWithEmail(),
                _isThinking,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
