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
  bool noResults = true;
  List<EventInfo> allEvents = [];
  List<EventInfo> filteredEvents = [];
  List<EventInfo> upcoming = [];
  List<EventInfo> filteredUpcoming = [];
  List<EventInfo> past = [];
  List<EventInfo> filteredPast = [];

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
        upcoming.addAll(allEvents
            .where((element) => element.endDate.isAfter(DateTime.now()))
            .toList());
        filteredUpcoming.addAll(upcoming);
        past.addAll(allEvents
            .where((element) => element.endDate.isBefore(DateTime.now()))
            .toList());
        filteredPast.addAll(past);
        isSearching = false;
      });
    });
    super.initState();
  }

  void _filterEvents(value, int tab) {
    print(tab);

    setState(() {
      filteredUpcoming = filteredUpcoming
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

    setState(() {
      filteredPast = filteredPast
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                    print("searchSelected");
                    print(DefaultTabController.of(context).index);
                    _filterEvents(
                        value, DefaultTabController.of(context).index);
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
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Upcoming",
                icon: Icon(Icons.account_balance_wallet),
              ),
              Tab(
                text: "All",
                icon: Icon(Icons.face),
              ),
              Tab(
                text: "Past",
                icon: Icon(Icons.dashboard),
              ),
            ],
          ),
        ),
        // appBar: AppBar(
        //   title: Text(
        //     'Saved Cards',
        //     style: TextStyle(fontFamily: 'Montserrat'),
        //   ),

        // ),
        body: TabBarView(
          children: <Widget>[
            // This container is for the ucoming Events
            Container(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      filteredUpcoming.length > 0
                          ? Expanded(
                              child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                  itemCount: filteredUpcoming.length,
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigator.of(context).pushNamed(Country.routeName,
                                        //     arguments: filteredUpcoming[index]);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: EventPreviewCard(
                                            filteredUpcoming[index]),
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
            // This container is for all Events
            Container(
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigator.of(context).pushNamed(Country.routeName,
                                        //     arguments: filteredEvents[index]);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: EventPreviewCard(
                                            filteredEvents[index]),
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
            // This container is for the Past Events
            Container(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      filteredPast.length > 0
                          ? Expanded(
                              child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                  itemCount: filteredPast.length,
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigator.of(context).pushNamed(Country.routeName,
                                        //     arguments: filteredPast[index]);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: EventPreviewCard(
                                            filteredPast[index]),
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
          ],
        ),
      ),
    );
  }
}
