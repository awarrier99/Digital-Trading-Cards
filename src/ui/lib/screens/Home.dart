import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/Cards/TradingCard.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Global.dart';
import '../palette.dart';
import '../components/RoundedButton.dart';

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
    if (userModel.currentUser.id != null) {
      userCardInfo = cardInfoModel.fetchCardInfo(
          userModel.currentUser.id, userModel.token,
          isCurrentUser: true);
    } else {
      userCardInfo = Future.value(CardInfo());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                    hasCard
                        ? TradingCard(snapshot.data, currentUser: true)
                        : Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('lib/assets/images/noCard.png'),
                                SizedBox(height: 20),
                                Text(
                                  'Make meaningful connections',
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
                                    'Create your digital trading card to share your story and grow your network',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Palette.secondary,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50),
                                RoundedButton(
                                  'Get started',
                                  Palette.primary,
                                  () {
                                    final globalModel =
                                        context.read<GlobalModel>();
                                    globalModel.cardInfoModel.isEditing = false;
                                    Navigator.of(context)
                                        .pushNamed('/createCard1');
                                  },
                                  false,
                                ),
                              ],
                            ),
                          ),
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
