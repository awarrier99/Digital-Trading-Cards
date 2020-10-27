// Widget that will be used to diplay an events information
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/models/EventInfo.dart';

class EventCard extends StatelessWidget {
  final EventInfo data;

  const EventCard(this.data);

  @override
  Widget build(BuildContext) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xfff4f4f4), Color(0xfff8f8f8)],
            begin: Alignment.centerLeft,
            end: Alignment.center),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for the title of the event (event name)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${data.eventName}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24, height: .5),
                ),
              ],
            ),
            // Container that will hold the main information for the event
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Start Date: "),
                      Text(DateFormat('MM-dd-yyyy – kk:mm:a')
                          .format(data.startDate)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("End Date: "),
                      Text(DateFormat('MM-dd-yyyy – kk:mm:a')
                          .format(data.endDate)),
                    ],
                  ),
                  Text("Contact Information"),
                  Text('${data.owner.firstName} ${data.owner.lastName}'),
                  Text('${data.owner.company}'),
                  Text('${data.owner.username}'),
                  Text("Description & Details"),
                  Text(
                      "this needs to be in the database but its not right now"),
                  Text('${data.owner.website}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
