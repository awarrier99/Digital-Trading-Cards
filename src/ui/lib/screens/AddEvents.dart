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
                        if (_eventInputsKey.currentState.validate()) {
                          final globalModel = context.read<GlobalModel>();
                          final eventModel = globalModel.eventInfoModel;
                          eventModel.createEvent();
                          // include a check in the future for dupes
                        }
                        sendToViewEventScreen(context);
                        // Navigator.of(context)
                        // go to preview page or go back to view events page
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
