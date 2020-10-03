import 'package:flutter/material.dart';
import 'package:ui/models/Global.dart';

import '../components/Cards/SummaryCard.dart';
import 'package:ui/models/ConnectionInfo.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/User.dart';
import 'package:provider/provider.dart';

class ViewSavedCards extends StatefulWidget {
  @override
  _ViewSavedCardsState createState() => _ViewSavedCardsState();
}

class _ViewSavedCardsState extends State<ViewSavedCards> {
  Future<ConnectionInfo> userConnectionInfo;

  @override
  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final connectionInfoModel = globalModel.connectionInfoModel;
    final userModel = globalModel.userModel;
    userConnectionInfo = connectionInfoModel.fetchConnectionInfo(
        userModel.currentUser.id, userModel.token,
        isCurrentUser: false);
  }

  final _createAccountFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Cards',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: Container(
        child: FutureBuilder<ConnectionInfo>(
            future: userConnectionInfo,
            builder: (context, AsyncSnapshot<ConnectionInfo> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                // children = [SummaryCard(snapshot.data, currentUser: true)];
                print(snapshot.data);
                children = [
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: snapshot.data.connectedUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child:
                              SummaryCard(snapshot.data.connectedUsers[index]));
                    },
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                  ),
                ];
              } else if (snapshot.hasError) {
                children = [
                  Center(
                    child: Container(
                      child: Text("${snapshot.error}"),
                    ),
                  ),
                ];
              } else {
                children = [
                  Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ];
              }
              return Flex(
                direction: Axis.vertical,
                children: children,
              );
            }),
      ),
    );
  }
}
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text(
//         'Saved Cards',
//         style: TextStyle(fontFamily: 'Montserrat'),
//       ),
//     ),
//     body: ListView.separated(
//       separatorBuilder: (BuildContext context, int index) => const Divider(),
//       itemCount: savedCardsList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//           child: new SummaryCard(
//               savedCardsList[index]['fullname'],
//               savedCardsList[index]['school'],
//               savedCardsList[index]['degreeType'],
//               savedCardsList[index]['major'],
//               savedCardsList[index]['skills'],
//               savedCardsList[index]['interests'],
//               savedCardsList[index]['isFavorite']),
//         );
//       },
//       padding: EdgeInsets.only(top: 10, bottom: 10),
//     ),
//   );
// }
