import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/palette.dart';
import 'package:intl/intl.dart';
// an event has a name, a host, a start time and an end time

class EventPreviewCard extends StatefulWidget {
  // This will need to be replaced with a model probably
  EventInfo data;

  EventPreviewCard(this.data);

  @override
  _EventPreviewState createState() => _EventPreviewState();
}

class _EventPreviewState extends State<EventPreviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
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
              FittedBox(
                fit: BoxFit.fitWidth,
                child: AutoSizeText(
                  widget.data.eventName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              children: [
                Text(
                  widget.data.owner.firstName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[700],
                  ),
                ),
                Text(" "),
                Text(
                  widget.data.owner.lastName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              children: [
                Text(
                  DateFormat('MM-dd-yyyy – kk:mm:a')
                      .format(widget.data.startDate),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[700],
                  ),
                ),
                Text(" "),
                Text(
                  DateFormat('MM-dd-yyyy – kk:mm:a')
                      .format(widget.data.endDate),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
