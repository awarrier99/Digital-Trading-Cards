// Widget that will be used to diplay an events information
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/models/User.dart';
import 'package:ui/palette.dart';
import 'package:ui/screens/ViewAttendees.dart';
import 'package:ui/models/Global.dart';

// This widget displays an event card that displays all the information about
// the event taken from the model

class EventCard extends StatefulWidget {
  final EventInfo data;
  final List<User> attendees;

  const EventCard(this.data, this.attendees);
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  Future goToAttendees(context) async {
    // Navigator.of(context).pushNamed('/viewAttendees');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ViewAttendees(widget.attendees, widget.data)));
  }

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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    '${widget.data.eventName}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Palette.primary),
                  ),
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
                            .format(widget.data.startDate),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("End: "),
                      Text(
                        DateFormat('MMM dd, yyyy kk:mm a')
                            .format(widget.data.endDate),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 20),
                    child: Text(
                      "Contact",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.data.owner.firstName} ${widget.data.owner.lastName}',
                  ),
                  Text('${widget.data.company}'),
                  Text('${widget.data.owner.username}'),
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
                  Text('${widget.data.eventDescription}'),
                  Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 20),
                      child: Row(
                        children: [
                          Text(
                            "Attendees",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                                goToAttendees(context);
                              },
                              child: Row(
                                children: widget.attendees.length == 0
                                    ? []
                                    : [
                                        Text(
                                          "view all cards",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12,
                                        )
                                      ],
                              ))
                        ],
                      )),
                  Row(
                    children: widget.attendees.length == 0
                        ? [Text("None yet - go ahead and RSVP!")]
                        : [
                            for (var user in widget.attendees)
                              Container(
                                decoration: BoxDecoration(
                                    color: Palette.primary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    '${user.firstName[0]}${user.lastName[0]}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                          ],
                  ),
                  // Container(
                  //     height: 40,
                  //     child: Material(
                  //       borderRadius: BorderRadius.circular(20),
                  //       shadowColor: Palette.secondary,
                  //       color: Palette.secondary,
                  //       elevation: 7,
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           print('hello');
                  //           print(widget.data.id);
                  //           final globalModel = context.read<GlobalModel>();
                  //           final eventModel = globalModel.eventInfoModel;
                  //           final userModel = globalModel.userModel;

                  //         },
                  //         child: Center(
                  //           child: Text(
                  //             'RSVP',
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: 'Montserrat'),
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
