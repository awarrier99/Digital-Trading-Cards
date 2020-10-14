import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ui/palette.dart';
// an event has a name, a host, a start time and an end time

class EventPreviewCard extends StatefulWidget {
  // This will need to be replaced with a model probably
  String eventName;
  String hostName;
  String startDate;
  String endDate;

  EventPreviewCard(this.eventName, this.hostName, this.startDate, this.endDate);

  @override
  _EventPreviewState createState() => _EventPreviewState();
}

class _EventPreviewState extends State<EventPreviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      decoration: BoxDecoration(
        color: Palette.secondary,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        gradient: RadialGradient(
          center: Alignment(0.6, 2.0),
          radius: 10,
          colors: [
            Colors.white,
            Colors.grey[600],
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              AutoSizeText(
                widget.eventName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey[700],
                ),
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
