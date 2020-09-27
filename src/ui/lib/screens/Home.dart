import 'package:flutter/material.dart';
import 'package:ui/components/Cards/TradingCard.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/User.dart';
import '../palette.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<CardInfo> userCardInfo;

  @override
  void initState() {
    super.initState();
    final cardInfoModel = context.read<CardInfoModel>();
    final userModel = context.read<UserModel>();
    userCardInfo =
        cardInfoModel.fetchCardInfo(userModel.currentUser.id, userModel.token);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: SingleChildScrollView(
                child: Column(children: [
      FutureBuilder<CardInfo>(
        future: userCardInfo,
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            print("SNAPSHOT DATA");
            print(snapshot.data);
            children = [
              TradingCard(
                snapshot.data,
              )
            ];
          } else if (snapshot.hasError) {
            children = [
              Center(
                child: Container(
                  child: Text("${snapshot.error}"),
                ),
              )
            ];
          } else {
            children = [
              Center(
                child: CircularProgressIndicator(),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
      RaisedButton(
          child: Text('Create Card'),
          textColor: Colors.white,
          color: Palette.primaryGreen,
          onPressed: () {
            Navigator.of(context).pushNamed('/createCard1');
          }),
    ]))));
  }
}
