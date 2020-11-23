// import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/EventInfo.dart';
import 'package:ui/palette.dart';
import 'package:intl/intl.dart';

// This Widget form contains the Input Widgets that are needed to take in
// input from the user when creating and updating an Event.

class EventInputs extends StatefulWidget {
  // final GlobalKey key;
  final EventInfo model;
  final bool isEditing;

  EventInputs({/*@required this.key,*/ @required this.model, this.isEditing});

  @override
  State<StatefulWidget> createState() {
    return EventInputsState();
  }
}

class EventInputsState extends State<EventInputs> {
  FocusNode titleNode = FocusNode();
  FocusNode organizationNode = FocusNode();
  FocusNode descriptionNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNumberNode = FocusNode();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    if (widget.isEditing) {
      startDate = widget.model.startDate;
      endDate = widget.model.endDate;
      selectedStartTime =
          TimeOfDay(hour: startDate.hour, minute: startDate.minute);
      selectedEndTime = TimeOfDay(hour: endDate.hour, minute: endDate.minute);
    } else {
      widget.model.startDate = startDate;
      widget.model.endDate = endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: widget.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: true,
            child: Text(
              'New Event',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  color: Colors.deepPurple),
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _buildEventName(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _buildEventOrganization(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Visibility(
            visible: true,
            child: Text(
              'Event Description',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  color: Colors.deepPurple),
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _buildEventDescription(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Visibility(
            visible: true,
            child: Text(
              'Contact Information',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  color: Colors.deepPurple),
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _buildEventContactEmail(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _buildEventContactPhoneNumber(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Visibility(
            visible: true,
            child: Text(
              'Date & Time of the Event',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  color: Colors.deepPurple),
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _buildStartEventDate(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _buildEndEventDate(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _buildEventStartTime(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _buildEventEndTime(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
        ],
      ),
    );
  }

  // Textfield input for Event Name
  Widget _buildEventName() {
    return TextInput(
      initialValue: widget.isEditing ? widget.model.eventName : "",
      decoration: InputDecoration(
          labelText: 'Name of Event*', border: OutlineInputBorder()),
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onChanged: (value) {
        // place this value into create event info model
        widget.model.eventName = value;
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(organizationNode);
      },
    );
  }

  // Textfield input for Organization Name
  Widget _buildEventOrganization() {
    return TextInput(
      initialValue: widget.isEditing ? widget.model.company : "",
      decoration: InputDecoration(
          labelText: 'Company/Organization Name*',
          border: OutlineInputBorder()),
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onChanged: (value) {
        // place this value into create event info model
        widget.model.company = value;
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(descriptionNode);
      },
    );
  }

  // Textfield input for Event Description
  Widget _buildEventDescription() {
    return TextInput(
      initialValue: widget.isEditing ? widget.model.eventDescription : "",
      decoration: InputDecoration(
        labelText: 'Event Description*',
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onChanged: (value) {
        // place this value into create event info model
        widget.model.eventDescription = value;
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(emailNode);
      },
    );
  }

  // Textfield input for Contact Email
  Widget _buildEventContactEmail() {
    return TextInput(
      initialValue: widget.isEditing ? widget.model.owner.username : "",
      decoration: InputDecoration(
          labelText: 'Email Address', border: OutlineInputBorder()),
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Required';
      //   }
      //   return null;
      // },
      onChanged: (value) {
        // place this value into create event info model
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(phoneNumberNode);
      },
    );
  }

  // Textfield input for Contact Phone #
  Widget _buildEventContactPhoneNumber() {
    return TextInput(
      initialValue: widget.isEditing ? "" : "",
      decoration: InputDecoration(
          labelText: 'Phone Number', border: OutlineInputBorder()),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        // place this value into create event info model
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(titleNode);
      },
    );
  }

  // need to set edge case where start date is further ahead then end date
  Future<void> _selectDate(bool start) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 10),
        lastDate: DateTime(2101));
    if (start) {
      if (picked != null && picked != startDate) {
        setState(() {
          startDate = picked;
          widget.model.startDate = picked;
        });
      }
    } else if (picked != null && picked != endDate && !start) {
      setState(() {
        endDate = picked;
        widget.model.endDate = picked;
      });
    }
  }

  // Data Picker widget
  Widget _buildStartEventDate() {
    String date = DateFormat.yMMMMd().format(startDate);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
          RaisedButton(
            onPressed: () {
              _selectDate(true);
            },
            child: Text('Select a Start date'),
          ),
        ],
      ),
    );
  }

  Widget _buildEndEventDate() {
    String date = DateFormat.yMMMMd().format(endDate);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
          RaisedButton(
            onPressed: () {
              _selectDate(false);
            },
            child: Text('Select an end date'),
          ),
        ],
      ),
    );
  }

  String startTime;
  String endTime;

  Future<Null> selectTime(BuildContext context, bool start) async {
    final TimeOfDay _time =
        await showTimePicker(context: context, initialTime: selectedStartTime);

    if (start) {
      if (_time != null && _time != selectedStartTime) {
        setState(() {
          selectedStartTime = _time;
        });
      }
    } else if (_time != null && _time != selectedEndTime && !start) {
      setState(() {
        selectedEndTime = _time;
      });
    }

    widget.model.startDate = returnDateAndTime(startDate, selectedStartTime);
    widget.model.endDate = returnDateAndTime(endDate, selectedEndTime);

    print("start");
    print(widget.model.startDate);
    print("end");
    print(widget.model.endDate);
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  Widget _buildEventStartTime() {
    // startTime = formatTimeOfDay(TimeOfDay.now());
    startTime = formatTimeOfDay(selectedStartTime);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            startTime,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
          RaisedButton(
              onPressed: () {
                selectTime(context, true);
                // update data in the model here
              },
              child: Text(
                'Select a start time',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ))
        ],
      ),
    );
  }

  // Time Picker widget
  Widget _buildEventEndTime() {
    endTime = formatTimeOfDay(selectedEndTime);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            endTime,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
          RaisedButton(
              onPressed: () {
                selectTime(context, false);
                // update data in the model here
              },
              child: Text(
                'Select an end time',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ))
        ],
      ),
    );
  }

  // takes in the day and time and returns a date as a string
  DateTime returnDateAndTime(DateTime date, TimeOfDay time) {
    date = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    // final format = DateFormat.yMMMMd().add_jm();
    // return format.format(date);
    return date;
  }
}
