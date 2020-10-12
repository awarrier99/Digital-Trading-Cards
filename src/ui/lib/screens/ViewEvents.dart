import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ui/models/Global.dart';

import '../components/Cards/SummaryCard.dart';
import 'package:ui/models/ConnectionInfo.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/User.dart';
import 'package:provider/provider.dart';

class ViewEvents extends StatefulWidget {
  @override
  _ViewEventsState createState() => _ViewEventsState();
}

class _ViewEventsState extends State<ViewEvents> {
  bool isSearching = false;

  @override
  void initState() {
    final globalModel = context.read<GlobalModel>();
    final connectionInfoModel = globalModel.connectionInfoModel;
    final userModel = globalModel.userModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Events',
            style: TextStyle(fontFamily: 'Montserrat'),
          )),
      body: Container(),
    );
  }
}
