import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/Cards/EventCard.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/models/User.dart';
import 'package:ui/palette.dart';
import 'package:ui/screens/AddEvents.dart';

class ViewEvent extends StatefulWidget {
  final int eventId;

  const ViewEvent(this.eventId);
  @override
  _ViewEventState createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  Future<EventInfo> eventInfo;
  Future<List<User>> attendees;
  bool isOwner;
  int currentUserID;

  @override
  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final cardInfoModel = globalModel.cardInfoModel;
    final userModel = globalModel.userModel;
    final eventModel = globalModel.eventInfoModel;
    eventInfo = eventModel.fetchEventInfo(widget.eventId, userModel.token);
    attendees = eventModel.fetchAttendees(widget.eventId, userModel.token);

    currentUserID = userModel.currentUser.id;
    isOwner = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: FutureBuilder<List<dynamic>>(
        future: Future.wait([eventInfo, attendees]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (currentUserID == snapshot.data[0].owner.id) {
              isOwner = true;
            }
            children = [
              EventCard(snapshot.data[0], snapshot.data[1]),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  shadowColor: Palette.secondary,
                  color: Palette.secondary,
                  elevation: 7,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/viewEvents');

                      // int currUserId = globalModel.userModel.currentUser;
                      // final globalModel = context.read<GlobalModel>();
                      // final userModel = globalModel.userModel;
                      // final eventModel = globalModel.eventInfoModel.eventInfo;
                      // print(eventModel.eventId);
                      // widget
                      //     .registerForEvent(userModel.token)
                      //     .then((success) {
                      //   if (success) {
                      //     print("RSVP successful");
                      //   }
                      // });
                      // print(userModel.currentUser.id);
                      // final userModel = globalModel.userModel;
                    },
                    child: Center(
                      child: Text(
                        'RSVP',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              isOwner
                  ? Container(
                      margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                      height: 40,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Palette.secondary,
                        color: Palette.secondary,
                        elevation: 7,
                        child: GestureDetector(
                          onTap: () {
                            final globalModel = context.read<GlobalModel>();
                            globalModel.eventInfoModel.isEditing = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEvents(
                                        snapshot.data[0].id,
                                        snapshot.data[0])));
                          },
                          child: Center(
                            child: Text(
                              'Edit Event',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ];
          } else if (snapshot.hasError) {
            children = [
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                title: snapshot.error,
                duration: Duration(seconds: 5),
                margin: EdgeInsets.all(8),
                borderRadius: 8,
                backgroundColor: Color(0xffDF360E),
              )..show(context)
            ];
          } else {
            children = [
              Center(
                child: CircularProgressIndicator(),
              )
            ];
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            ],
          ));
        },
      ),
    ));
  }
}
