import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/ConnectionInfo.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/models/User.dart';

import '../components/Cards/SummaryCard.dart';

class ViewSavedCards extends StatefulWidget {
  @override
  _ViewSavedCardsState createState() => _ViewSavedCardsState();
}

class _ViewSavedCardsState extends State<ViewSavedCards> {
  ConnectionInfo userConnectionInfo;
  List<CardInfo> connectionCards = [];
  List<CardInfo> filteredUsers = [];
  // List<String> interestsFilter = [];
  // List<String> skillsFilter = [];
  // List<String> availableInterests = [];
  // List<String> availableSkills = [];
  // String dropDownInterest;
  // String dropDownSkill;
  bool isSearching = false;

  getConnectionInfo(ConnectionInfoModel connectionInfoModel,
      UserModel userModel, bool isCurrentUser) async {
    var userConnectionInfo = await connectionInfoModel.fetchConnectionInfo(
        userModel.currentUser.id, userModel.token);
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
        // interestsFilter = data.interests;
        // availableInterests.add("All");
        // availableInterests.addAll(data.interests);
        // availableInterests.sort((a, b) => a.toString().compareTo(b.toString()));
        // dropDownInterest = "All";
        // availableSkills.add("All");
        // availableSkills.addAll(data.skills);
        // availableSkills.sort((a, b) => a.toString().compareTo(b.toString()));
        // dropDownSkill = "All";
        connectionCards = filteredUsers = data.connectionCards;
        isSearching = false;
      });
    });
    super.initState();
  }

  void _filterCards(value) {
    setState(() {
      filteredUsers = filteredUsers
          .where((card) =>
              card.user.firstName.toLowerCase().contains(value.toLowerCase()) ||
              card.user.lastName.toLowerCase().contains(value.toLowerCase()))
          .toList();
      // filteredUsers = connectedUsers
      //     .where((card) => List.from(card.interests
      //             .map((e) => (e.interest.title).toString().toLowerCase())
      //             .toList())
      //         .any((e) => e.contains(value.toLowerCase())))
      //     .toList();
    });
  }

  // void _filterCardsBySkillAndInterest() {
  //   if (dropDownInterest == "All" && dropDownSkill == "All") {
  //     setState(() {
  //       filteredUsers = connectionCards;
  //     });
  //   } else if (dropDownSkill == "All") {
  //     setState(() {
  //       filteredUsers = connectionCards
  //           .where((card) => List.from(card.interests
  //                   .map((e) => (e.interest.title).toString().toLowerCase())
  //                   .toList())
  //               .any((e) => e == dropDownInterest.toLowerCase()))
  //           .toList();
  //     });
  //   } else if (dropDownInterest == "All") {
  //     setState(() {
  //       filteredUsers = connectionCards
  //           .where((card) => List.from(card.skills
  //                   .map((e) => (e.skill.title).toString().toLowerCase())
  //                   .toList())
  //               .any((e) => e == dropDownSkill.toLowerCase()))
  //           .toList();
  //     });
  //   } else {
  //     setState(() {
  //       filteredUsers = connectionCards
  //           .where((card) =>
  //               List.from(card.interests
  //                       .map((e) => (e.interest.title).toString().toLowerCase())
  //                       .toList())
  //                   .any((e) => e == dropDownInterest.toLowerCase()) &&
  //               List.from(card.skills
  //                       .map((e) => (e.skill.title).toString().toLowerCase())
  //                       .toList())
  //                   .any((e) => e == dropDownSkill.toLowerCase()))
  //           .toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                    hintText: "Search Cards",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      this.filteredUsers = connectionCards;
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
        leading: isSearching
            ? null
            : IconButton(
                icon: Icon(Icons.pending),
                onPressed: () {
                  Navigator.of(context).pushNamed('/PendingConnections');
                },
              ),
      ),
      // appBar: AppBar(
      //   title: Text(
      //     'Saved Cards',
      //     style: TextStyle(fontFamily: 'Montserrat'),
      //   ),

      // ),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // SizedBox(
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 2),
                //           child: Column(
                //             children: <Widget>[
                //               Text(
                //                 'Interests',
                //                 style: TextStyle(
                //                     fontFamily: 'Montserrat', fontSize: 12),
                //               ),
                //               DropdownButton<String>(
                //                 value: dropDownInterest,
                //                 onChanged: (String newValue) {
                //                   setState(() {
                //                     dropDownInterest = newValue;
                //                     _filterCardsBySkillAndInterest();
                //                   });
                //                 },
                //                 items: availableInterests
                //                     .map<DropdownMenuItem<String>>(
                //                         (String value) {
                //                   return DropdownMenuItem<String>(
                //                     value: value,
                //                     child: Text(value),
                //                   );
                //                 }).toList(),
                //                 isExpanded: false,
                //                 hint: Text("Interests"),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 2),
                //           child: Column(
                //             children: <Widget>[
                //               Text(
                //                 'Skills',
                //                 style: TextStyle(
                //                     fontFamily: 'Montserrat', fontSize: 12),
                //               ),
                //               DropdownButton<String>(
                //                 value: dropDownSkill,
                //                 onChanged: (String newValue) {
                //                   setState(() {
                //                     dropDownSkill = newValue;
                //                     _filterCardsBySkillAndInterest();
                //                   });
                //                 },
                //                 items: availableSkills
                //                     .map<DropdownMenuItem<String>>(
                //                         (String value) {
                //                   return DropdownMenuItem<String>(
                //                     value: value,
                //                     child: Text(value),
                //                   );
                //                 }).toList(),
                //                 isExpanded: false,
                //                 hint: Text("Skills"),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                filteredUsers.length > 0
                    ? Expanded(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
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
                            }),
                      )
                    : Center(
                        child: Text(
                        'No saved cards',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            height: .5),
                      )),
              ],
            ),
          ),
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
