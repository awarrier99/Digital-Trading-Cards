import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
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
  ConnectionInfo userConnectionInfo;
  List<CardInfo> connectedUsers = [];
  List<CardInfo> filteredUsers = [];
  List<String> interestsFilter = [];
  List<String> skillsFilter = [];
  bool isSearching = false;

  getConnectionInfo(ConnectionInfoModel connectionInfoModel,
      UserModel userModel, bool isCurrentUser) async {
    var userConnectionInfo = await connectionInfoModel.fetchConnectionInfo(
        userModel.currentUser.id, userModel.token,
        isCurrentUser: false);
    return userConnectionInfo;
  }

  @override
  void initState() {
    final globalModel = context.read<GlobalModel>();
    final connectionInfoModel = globalModel.connectionInfoModel;
    final userModel = globalModel.userModel;
    getConnectionInfo(connectionInfoModel, userModel, false).then((data) {
      setState(() {
        userConnectionInfo = data;
        interestsFilter = data.interests;
        connectedUsers = filteredUsers = data.connectedUsers;
        isSearching = false;
      });
    });
    super.initState();
  }

  void _filterCards(value) {
    setState(() {
      filteredUsers = connectedUsers
          .where((card) => List.from(card.interests
                  .map((e) => (e.interest.title).toString().toLowerCase())
                  .toList())
              .any((e) => e.contains(value.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: !isSearching
            ? Text(
                'Saved Cards',
                style: TextStyle(fontFamily: 'Montserrat'),
              )
            : TextField(
                onChanged: (value) {
                  _filterCards(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search Country Here",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      this.filteredUsers = connectedUsers;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                )
        ],
      ),
      // appBar: AppBar(
      //   title: Text(
      //     'Saved Cards',
      //     style: TextStyle(fontFamily: 'Montserrat'),
      //   ),

      // ),
      body: Container(
        child: filteredUsers.length > 0
            ? ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: filteredUsers.length,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed(Country.routeName,
                      //     arguments: filteredUsers[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: SummaryCard(filteredUsers[index]),
                    ),
                  );

                  // child: Card(
                  //   elevation: 10,
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 10, horizontal: 8),
                  //     child: Text(
                  //       filteredCountries[index]['name'],
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //   ),
                  // ),
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      // body: Container(
      //   child: FutureBuilder<ConnectionInfo>(
      //       future: userConnectionInfo,
      //       builder: (context, AsyncSnapshot<ConnectionInfo> snapshot) {
      //         List<Widget> children;
      //         if (snapshot.hasData) {
      //           // children = [SummaryCard(snapshot.data, currentUser: true)];
      //           print(snapshot.data);
      //           children = [
      //             ListView.separated(
      //               scrollDirection: Axis.vertical,
      //               shrinkWrap: true,
      //               separatorBuilder: (BuildContext context, int index) =>
      //                   const Divider(),
      //               itemCount: snapshot.data.connectedUsers.length,
      //               itemBuilder: (BuildContext context, int index) {
      //                 return Container(
      //                     padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      //                     child:
      //                         SummaryCard(snapshot.data.connectedUsers[index]));
      //               },
      //               padding: EdgeInsets.only(top: 10, bottom: 10),
      //             ),
      //           ];
      //         } else if (snapshot.hasError) {
      //           children = [
      //             Center(
      //               child: Container(
      //                 child: Text("${snapshot.error}"),
      //               ),
      //             ),
      //           ];
      //         } else {
      //           children = [
      //             Center(
      //               child: Container(
      //                 child: CircularProgressIndicator(),
      //               ),
      //             ),
      //           ];
      //         }
      //         return Flex(
      //           direction: Axis.vertical,
      //           children: children,
      //         );
      //       }),
      // ),
    );
  }
}
