import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/forms/EventInputs.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/models/Global.dart';

class AddEvents extends StatelessWidget {
  final _eventInputsKey = GlobalKey<FormState>();
  final _eventsInfoModel = EventInfo();

  Future sendToViewEventScreen(context) async {
    Navigator.of(context).pushNamed('/viewEvents');
  }

  @override
  Widget build(BuildContext context) {
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
                EventInputs(
                  key: _eventInputsKey,
                  model: _eventsInfoModel,
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 10),
                SizedBox(
                  child: RaisedButton(
                      child: Text('Create event'),
                      textColor: Colors.white,
                      color: Colors.deepPurple,
                      onPressed: () {
                        print('hello');
                        if (_eventInputsKey.currentState.validate()) {
                          print('hello1');
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
