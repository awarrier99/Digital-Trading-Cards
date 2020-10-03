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
  int userId = 55;
  Future<CardInfo> userCardInfo;

  @override
  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final cardInfoModel = globalModel.cardInfoModel;
    final userModel = globalModel.userModel;
    userCardInfo =
        cardInfoModel.fetchCardInfo(userModel.currentUser.id, userModel.token);
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
        child: FutureBuilder<CardInfo>(
            future: userCardInfo,
            builder: (context, AsyncSnapshot<CardInfo> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = [SummaryCard(snapshot.data, currentUser: true)];
                // children = [
                // ListView.separated(
                //   separatorBuilder: (BuildContext context,
                //       int index) => const Divider(),
                //   itemCount: snapshot.data.connectedUsers.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return Container(
                //         padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                //         child: SummaryCard(
                //             snapshot.data.connectedUsers[index].id
                //           // snapshot.data.connectedUsers[index].toJson['fullname'],
                //           // snapshot.data.connectedUsers[index]['school'],
                //           // snapshot.data.connectedUsers[index]['degreeType'],
                //           // snapshot.data.connectedUsers[index]['major'],
                //           // snapshot.data.connectedUsers[index]['skills'],
                //           // snapshot.data.connectedUsers[index]['interests'],
                //           // false),
                //         )
                //     );
                //   },
                //   padding: EdgeInsets.only(top: 10, bottom: 10),
                // ),
                // ];
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
              return Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Column(
                  children: children,
                ),
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
