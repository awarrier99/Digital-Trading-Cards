import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/forms/EventInputs.dart';

class AddEvents extends StatelessWidget {
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
                EventInputs(), // insert some params in the constructor
                SizedBox(height: SizeConfig.safeBlockVertical * 10),
                SizedBox(
                  child: RaisedButton(
                      child: Text('Create event'),
                      textColor: Colors.white,
                      color: Colors.deepPurple,
                      onPressed: () {
                        if (true) {
                          // form validation here
                          // update event model for this event
                        }
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
