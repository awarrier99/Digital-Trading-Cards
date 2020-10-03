import 'package:flutter/material.dart';
import 'package:ui/components/Cards/TradingCard.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Global.dart';
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
    final globalModel = context.read<GlobalModel>();
    final cardInfoModel = globalModel.cardInfoModel;
    final userModel = globalModel.userModel;
    userCardInfo = cardInfoModel.fetchCardInfo(
        userModel.currentUser.id, userModel.token,
        isCurrentUser: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: FutureBuilder<CardInfo>(
        future: userCardInfo,
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            CardInfo cardData = snapshot.data;
            bool hasCard = (cardData.education.isNotEmpty ||
                cardData.work.isNotEmpty ||
                cardData.volunteering.isNotEmpty);
            children = [
              hasCard
                  ? TradingCard(snapshot.data, currentUser: true)
                  : RaisedButton(
                      child: Text('Create Card'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        final globalModel = context.read<GlobalModel>();
                        globalModel.cardInfoModel.isEditing = false;
                        Navigator.of(context).pushNamed('/createCard1');
                      }),
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
    ));
  }
}
