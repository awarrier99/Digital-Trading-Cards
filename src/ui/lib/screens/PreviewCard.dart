import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:ui/models/Global.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/Cards/TradingCard.dart';
import 'package:ui/models/CardInfo.dart';
import '../palette.dart';

class PreviewCard extends StatefulWidget {
  final int userID;

  PreviewCard(this.userID);

  @override
  _PreviewCardState createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
  Future<CardInfo> connectionCardInfo;

  @override
  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final userModel = globalModel.userModel;
    final cardInfoModel = new CardInfoModel();
    connectionCardInfo = cardInfoModel.fetchCardInfo(
        userModel.currentUser.id, userModel.token,
        isCurrentUser: true);
    // currently showing card for currentUser.id. Need to show card for
    // passed in parameter userID
  }

  Future cancelCard(context) async {
    Navigator.of(context).pushNamed('/main');
  }

  Future saveCard(context) async {
    // Actually do the api save card / make connection stuff
    Navigator.of(context).pushNamed('/savedCards');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Card',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
        body: Center(
          child: FutureBuilder<CardInfo>(
            future: connectionCardInfo,
            builder: (context, snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                CardInfo cardData = snapshot.data;
                bool hasCard = (cardData.education.isNotEmpty ||
                    cardData.work.isNotEmpty ||
                    cardData.volunteering.isNotEmpty);
                children = [
                  TradingCard(snapshot.data),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: RaisedButton(
                              onPressed: () => cancelCard(context),
                              child: Text("Cancel")),
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                      Container(
                          child: RaisedButton(
                            onPressed: () => saveCard(context),
                            child: Text("Save"),
                            color: Palette.primaryGreen,
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    ],
                  )
                ];
              } else if (snapshot.hasError) {
                children = [
                  Flushbar(
                    flushbarPosition: FlushbarPosition.TOP,
                    title: snapshot.error,
                    duration: Duration(seconds: 5),
                    margin: EdgeInsets.all(8),
                    borderRadius: 8,
                    backgroundColor: Color(0xffDF360E),
                  )..show(context)
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
