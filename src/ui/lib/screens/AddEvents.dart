import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/forms/EventInputs.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/models/Global.dart';

// made some changes that might need to be changed in routegenerator.dart
// for this path
class AddEvents extends StatefulWidget {
  final int eventId;
  final EventInfo event;

  const AddEvents(this.eventId, this.event);

  @override
  State<StatefulWidget> createState() => _AddEvents();
}

class _AddEvents extends State<AddEvents> {
  final _eventInputsKey = GlobalKey<FormState>();
  EventInfo _eventsInfoModel = EventInfo();
  // final bool isEditing;

  void deactivate() {
    super.deactivate();
    final globalModel = context.read<GlobalModel>();
    globalModel.eventInfoModel.isEditing = false;
  }

  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final eventModel = globalModel.eventInfoModel;
    // print(eventModel.isEditing);

    if (eventModel.isEditing) {
      _eventsInfoModel = widget.event;
    }
  }

  Future sendToViewEventScreen(context) async {
    // once we are done we are sent back to view events
    Navigator.of(context).pushNamed('/viewEvents');
  }

  @override
  Widget build(BuildContext context) {
    final globalModel = context.watch<GlobalModel>();
    final eventModel = globalModel.eventInfoModel.eventInfo;
    bool isEditing = globalModel.eventInfoModel.isEditing;

    print('wall');
    print(globalModel.eventInfoModel.isEditing);
    print('wall');
    print(isEditing);
    print('wall');

    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add New Event',
            style: TextStyle(fontFamily: 'Montserrat'),
          )),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _eventInputsKey,
            child: Column(
              children: [
                isEditing
                    ? EventInputs(model: _eventsInfoModel, Editing: true)
                    // event model should return previous event id from view event or event info
                    : EventInputs(
                        model: _eventsInfoModel,
                        Editing: false,
                      ),
                SizedBox(height: SizeConfig.safeBlockVertical * 10),
                SizedBox(
                  child: RaisedButton(
                      child: Text('Create event'),
                      textColor: Colors.white,
                      color: Colors.deepPurple,
                      onPressed: () {
                        // print('hello');
                        if (_eventInputsKey.currentState.validate()) {
                          // print('hello1');
                          final globalModel = context.read<GlobalModel>();
                          final eventModel = globalModel.eventInfoModel;
                          final userModel = globalModel.userModel;
                          _eventsInfoModel.owner = userModel.currentUser;
                          print(_eventsInfoModel.toJson());
                          eventModel.eventInfo.fromEvent(_eventsInfoModel);
                          eventModel
                              .createEvent(userModel.token)
                              .then((success) {
                            if (success) {
                              sendToViewEventScreen(context);
                            }
                          });
                          // include a check in the future for dupes
                        }
                        globalModel.eventInfoModel.isEditing = false;
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
 *
  class AddEvents extends StatelessWidget {
  //State<AddEvents> {
  final _eventInputsKey = GlobalKey<FormState>();
  final _eventsInfoModel = EventInfo();
  // Future<EventInfo> eventInfo;
  // final bool isEditing;

  // void initState() {
  //   super.initState();
  //   final globalModel = context.read<GlobalModel>();
  //   final userModel = globalModel.userModel;
  //   final eventModel = globalModel.eventInfoModel;
  //   eventInfo = eventModel.fetchEventInfo(widget.eventId, userModel.token);
  //   print(eventModel.isEditing);
  // }

  Future sendToViewEventScreen(context) async {
    Navigator.of(context).pushNamed('/viewEvents');
  }

  @override
  Widget build(BuildContext context) {
    final globalModel = context.watch<GlobalModel>();
    final eventModel = globalModel.eventInfoModel.eventInfo;
    final isEditing = globalModel.eventInfoModel.isEditing;
    // final isEditing = globalModel.userModel.currentUser.id;
    // print(temp);
    // print(isEditing);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add New Event',
            style: TextStyle(fontFamily: 'Montserrat'),
          )),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _eventInputsKey,
            child: Column(
              children: [
                isEditing
                    ? EventInputs(model: eventModel, isEditing: true) // event model should return previous event id from view event or event info
                    : EventInputs(
                        model: _eventsInfoModel,
                        isEditing: false,
                      ),
                SizedBox(height: SizeConfig.safeBlockVertical * 10),
                SizedBox(
                  child: RaisedButton(
                      child: Text('Create event'),
                      textColor: Colors.white,
                      color: Colors.deepPurple,
                      onPressed: () {
                        // print('hello');
                        if (_eventInputsKey.currentState.validate()) {
                          // print('hello1');
                          final globalModel = context.read<GlobalModel>();
                          final eventModel = globalModel.eventInfoModel;
                          final userModel = globalModel.userModel;
                          _eventsInfoModel.owner = userModel.currentUser;
                          print(_eventsInfoModel.toJson());
                          eventModel.eventInfo.fromEvent(_eventsInfoModel);
                          eventModel
                              .createEvent(userModel.token)
                              .then((success) {
                            if (success) {
                              sendToViewEventScreen(context);
                            }
                          });
                          // include a check in the future for dupes
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 
 */
