// Widget that will be used to diplay an events information
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/palette.dart';

class EventCard extends StatelessWidget {
  final EventInfo data;

  const EventCard(this.data);

  @override
  Widget build(BuildContext) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
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
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Palette.primary),
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text("Start: "),
                      Text(
                        DateFormat('MMM dd, yyyy kk:mm a')
                            .format(data.startDate),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("End: "),
                      Text(
                        DateFormat('MMM dd, yyyy kk:mm a').format(data.endDate),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 20),
                    child: Text(
                      "Contact Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    '${data.owner.firstName} ${data.owner.lastName}',
                  ),
                  // Text('${data.owner.company}'),
                  // Text('${data.owner.username}'),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 20),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  //TODO: this needs to be in the database but its not right now
                  Text("Event details"),
                  // Text('${data.owner.website}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
