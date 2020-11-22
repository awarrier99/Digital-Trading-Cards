import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/Cards/TradingCard.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/screens/Messaging.dart';
import '../palette.dart';
import '../components/RoundedButton.dart';

// SavedCard screen which hosts the user's card

class ViewSavedCard extends StatefulWidget {
  final int userId;

  const ViewSavedCard(this.userId);
  @override
  _ViewSavedCardState createState() => _ViewSavedCardState();
}

class _ViewSavedCardState extends State<ViewSavedCard> {
  Future<CardInfo> userCardInfo;

  @override
  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final cardInfoModel = globalModel.cardInfoModel;
    final userModel = globalModel.userModel;
    if (userModel.currentUser.id != null) {
      userCardInfo = cardInfoModel.fetchCardInfo(widget.userId, userModel.token,
          isCurrentUser: false);
    } else {
      userCardInfo = Future.value(CardInfo());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<CardInfo>(
              future: userCardInfo,
              builder: (context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  CardInfo cardData = snapshot.data;
                  bool hasCard = cardData != null &&
                      (cardData.education != null ||
                          cardData.work != null ||
                          cardData.volunteering != null) &&
                      (cardData.education.isNotEmpty ||
                          cardData.work.isNotEmpty ||
                          cardData.volunteering.isNotEmpty);
                  children = [
                    TradingCard(snapshot.data, currentUser: false),
                    SizedBox(),
                    Container(
                      margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                      height: 40,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Palette.secondary,
                        color: Palette.primary,
                        elevation: 7,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Messaging(widget.userId)));
                          },
                          child: Center(
                            child: Text(
                              'Message',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(),
                    SizedBox()
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
              }),
        ),
      ),
    );
  }
}
