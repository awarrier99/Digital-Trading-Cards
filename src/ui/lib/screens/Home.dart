import 'package:flutter/material.dart';
import 'package:ui/components/Cards/TradingCard.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:http/http.dart';
import 'dart:convert';

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
        RaisedButton(
            child: Text('Create Card'),
            textColor: Colors.white,
            color: Palette.primaryGreen,
            onPressed: () {
              createCard(context);
            }),
        TradingCard(userCardInfo),
      ],
    ))));
  }
}
