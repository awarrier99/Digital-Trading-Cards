import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/Cards/TradingCard.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/ConnectionInfo.dart';
import 'package:ui/models/Global.dart';

import '../palette.dart';

class PreviewCard extends StatefulWidget {
  final CardInfo cardInfo;
  final bool pending;
  final Connection connection;

  PreviewCard(Map<String, dynamic> arguments)
      : cardInfo = arguments['cardInfo'],
        pending = arguments['pending'],
        connection = arguments['connection'];

  @override
  _PreviewCardState createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
  Future cancelCard() async {
    Navigator.of(context).pop();
  }

  Future saveCard() async {
    final globalModel = context.read<GlobalModel>();
    final userModel = globalModel.userModel;
    final connectionInfoModel = globalModel.connectionInfoModel;
    connectionInfoModel
        .createConnection(widget.cardInfo.user, userModel.token)
        .then((success) {
      if (success)
        Navigator.of(context).pushNamed('/savedCards');
      else {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          message: 'You are already connected with this user',
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          backgroundColor: Color(0xffDF360E),
        )..show(context);
      }
    });
  }

  Future acceptConnection() async {
    final globalModel = context.read<GlobalModel>();
    final userModel = globalModel.userModel;
    final connectionInfoModel = globalModel.connectionInfoModel;
    connectionInfoModel
        .acceptConnection(widget.connection, userModel.token)
        .then((success) {
      if (success)
        Navigator.of(context).pushNamed('/savedCards');
      else {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          message: 'Something went wrong',
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          backgroundColor: Color(0xffDF360E),
        )..show(context);
      }
    });
  }

  Future rejectConnection() async {
    final globalModel = context.read<GlobalModel>();
    final userModel = globalModel.userModel;
    final connectionInfoModel = globalModel.connectionInfoModel;
    connectionInfoModel
        .rejectConnection(widget.connection.id, userModel.token)
        .then((success) {
      if (success)
        Navigator.of(context).pushNamed('/PendingConnections');
      else {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          message: 'Something went wrong',
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          backgroundColor: Color(0xffDF360E),
        )..show(context);
      }
    });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TradingCard(widget.cardInfo),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: RaisedButton(
                        onPressed: () => cancelCard(),
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                        color: Palette.secondary,
                      ),
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                  widget.pending
                      ? Container(
                          child: RaisedButton(
                            onPressed: () => rejectConnection(),
                            child: Text('Reject',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                            color: Colors.red,
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0))
                      : SizedBox.shrink(),
                  Container(
                      child: RaisedButton(
                        onPressed: () =>
                            widget.pending ? acceptConnection() : saveCard(),
                        child: Text(widget.pending ? 'Accept' : 'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                        color: Palette.primary,
                      ),
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                ],
              )
            ],
          ),
        ));
  }
}
