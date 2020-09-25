import 'package:flutter/material.dart';
import 'package:ui/components/Cards/TradingCard.dart';
import 'package:ui/models/CardInfo.dart';
<<<<<<< HEAD
import 'package:http/http.dart';
import 'dart:convert';
=======
>>>>>>> 8bd8a7701d1f22bf2138475e0687644d02169ae0

import '../palette.dart';
import 'CreateCard1.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int userID = 1;
  Future<CardInfo> userCardInfo;

  Future createCard(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateCard1()));
  }

  Future editCard(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateCard1()));
  }

  @override
  void initState() {
    super.initState();
    userCardInfo = fetchCardInfo(userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SizedBox(
                child: Column(
      children: [
        FutureBuilder<CardInfo>(
          future: userCardInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TradingCard(
                snapshot.data,
                editCard: this.editCard(context),
              );
            } else if (snapshot.hasError) {
              // TODO: Best way to check if user already has a card?
              return true
                  ? RaisedButton(
                      child: Text('Create Card'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        createCard(context);
                      })
                  : Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ],
    ))));
  }
}
