import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/ConnectionInfo.dart';
import 'package:ui/models/Global.dart';

import '../components/Cards/SummaryCard.dart';

// The UI screen to view the users's pending connection requests

class PendingConnections extends StatefulWidget {
  @override
  _PendingConnectionsState createState() => _PendingConnectionsState();
}

class _PendingConnectionsState extends State<PendingConnections> {
  Future<ConnectionInfo> userConnectionInfo;

  @override
  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final connectionInfoModel = globalModel.connectionInfoModel;
    final userModel = globalModel.userModel;
    userConnectionInfo = connectionInfoModel.fetchConnectionInfo(
        userModel.currentUser.id, userModel.token,
        onlyPending: true);
  }

  Future nextStep(CardInfo card, Connection connection) async {
    Navigator.of(context).pushNamed('/previewCard', arguments: {
      'cardInfo': card,
      'pending': true,
      'connection': connection
    });
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
              child: FutureBuilder<ConnectionInfo>(
                future: userConnectionInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final connectionCards = snapshot.data.connectionCards;
                    return connectionCards.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                                itemCount: connectionCards.length,
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      nextStep(connectionCards[index],
                                          snapshot.data.connections[index]);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child:
                                          SummaryCard(connectionCards[index]),
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Text(
                              'No pending incoming connections',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  height: .5),
                            ),
                          );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
        ),
      ),
    );
  }
}
