import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ui/components/Cards/EventPreviewCard.dart';
import 'package:ui/models/EventInfo.dart';
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
  List<EventInfo> allEvents = [];
  List<EventInfo> filteredEvents = [];

  getUpcomingEvents(EventInfoModel eventInfoModel, UserModel userModel,
      bool isCurrentUser) async {
    // var allEvents = await eventInfoModel.fetchUpcomingEvents(
    //     userModel.currentUser.id, userModel.token);
    var allEvents =
        await eventInfoModel.fetchUpcomingEvents(1, userModel.token);
    print(allEvents);
    return allEvents;
  }

  @override
  void initState() {
    final globalModel = context.read<GlobalModel>();
    final userModel = globalModel.userModel;
    final eventModel = globalModel.eventInfoModel;
    getUpcomingEvents(eventModel, userModel, false).then((data) {
      setState(() {
        allEvents.addAll(data);
        filteredEvents.addAll(data);
        isSearching = false;
      });
    });
    super.initState();
  }

  void _filterEvents(value) {
    setState(() {
      filteredEvents = filteredEvents
          .where((element) =>
              element.owner.firstName
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.owner.lastName
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.eventName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: !isSearching
            ? Text(
                'Events',
                style: TextStyle(fontFamily: 'Montserrat'),
              )
            : TextField(
                onChanged: (value) {
                  _filterEvents(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search Events",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      this.filteredEvents = allEvents;
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                filteredEvents.length > 0
                    ? Expanded(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: filteredEvents.length,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pushNamed(Country.routeName,
                                  //     arguments: filteredEvents[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child:
                                      EventPreviewCard(filteredEvents[index]),
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
