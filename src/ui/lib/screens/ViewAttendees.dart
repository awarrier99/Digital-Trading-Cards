import 'package:flutter/material.dart';
import 'package:ui/components/Cards/CardList.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/models/User.dart';

// The UI screen to view an event's attendees

class ViewAttendees extends StatefulWidget {
  final List<User> list;
  final EventInfo info;

  ViewAttendees(this.list, this.info);

  @override
  _ViewAttendeesState createState() => _ViewAttendeesState();
}

class _ViewAttendeesState extends State<ViewAttendees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendees for ${widget.info.eventName}"),
        centerTitle: true,
      ),
      body: CardList(widget.list),
    );
  }
}
