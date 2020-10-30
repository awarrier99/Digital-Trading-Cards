import 'package:flutter/material.dart';
import 'package:ui/models/Global.dart';

import '../components/Cards/SummaryCard.dart';
import 'package:ui/models/ConnectionInfo.dart';
import 'package:ui/models/CardInfo.dart';

class PendingConnections extends StatefulWidget {
  @override
  _PendingConnectionsState createState() => _PendingConnectionsState();
}

class _PendingConnectionsState extends State<PendingConnections> {
  ConnectionInfo userConnectionInfo;
  List<CardInfo> pendingConnections = [];

  getPendingConnections() async {
    //
  }

  @override
  void initState() {
    // final globalModel = context.read<GlobalModel>();
    // final userModel = globalModel.userModel;
    getPendingConnections() {}
    ;
    super.initState();
  }

  Future addEventScreen(context) async {
    Navigator.of(context).pushNamed('/AddEvents');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pending Connections',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                pendingConnections.length > 0
                    ? Expanded(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: pendingConnections.length,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // Preview Card
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: SummaryCard(pendingConnections[index]),
                                ),
                              );
                            }),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
