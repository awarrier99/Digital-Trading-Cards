import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/Cards/EventCard.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/models/User.dart';

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

  @override
  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final cardInfoModel = globalModel.cardInfoModel;
    final userModel = globalModel.userModel;
    final eventModel = globalModel.eventInfoModel;
    eventInfo = eventModel.fetchEventInfo(widget.eventId, userModel.token);
    attendees = eventModel.fetchAttendees(widget.eventId, userModel.token);

    isOwner = (userModel.currentUser.id == eventModel.eventInfo.owner.id);
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
            children = [
              EventCard(snapshot.data[0], snapshot.data[1]),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    ));
  }
}
