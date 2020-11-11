// import 'dart:html';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/models/User.dart';
import 'package:ui/palette.dart';
import 'package:intl/intl.dart';

// Summary of an event contains a name, a host, a start time and an end time,
// and a date. Displays in a tile format on the View Event Screen.

class EventPreviewCard extends StatefulWidget {
  // This will need to be replaced with a model probably
  EventInfo data;

  EventPreviewCard(
    this.data,
  );

  @override
  _EventPreviewState createState() => _EventPreviewState();
}

class _EventPreviewState extends State<EventPreviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      decoration: BoxDecoration(
        color: Palette.lightGray,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 30,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: Palette.primary,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd').format(widget.data.startDate),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  Text(
                    DateFormat('MMM').format(widget.data.startDate),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Palette.primary,
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
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(" "),
                      Text(
                        widget.data.owner.lastName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('MMM dd, yyyy kk:mm a')
                              .format(widget.data.startDate),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy kk:mm a')
                              .format(widget.data.endDate),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    )),
              ],
            ))
      ]),
    );
  }
}
