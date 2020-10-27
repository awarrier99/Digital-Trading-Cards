import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/palette.dart';

class EventInputs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventInputsState();
  }
}

class EventInputsState extends State<EventInputs> {
  // FocusNodes init for later use to change textfield focus when
  // the user hits the continue button on the keyboard.
  FocusNode titleNode = FocusNode();
  FocusNode organizationNode = FocusNode();
  FocusNode descriptionNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode phoneNumberNode = FocusNode();

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
          // _buildEventDescription(),
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
          // _buildEventDate(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          // _buildEventTime(),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          // add a button right under this comment for submission
        ],
      ),
    );
  }

  // Textfield input for Event Name
  Widget _buildEventName() {
    return TextInput(
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
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(organizationNode);
      },
    );
  }

  // Textfield input for Organization Name
  Widget _buildEventOrganization() {
    return TextInput(
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
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(descriptionNode);
      },
    );
  }

  // Textfield input for Event Description
  Widget _buildEventDescription() {
    // need to edit this too be able to add multlines
    // I think Ashvin included a maxline property that can deal with this

    return TextInput(
      decoration: InputDecoration(
          labelText: 'Event Description*', border: OutlineInputBorder()),
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onChanged: (value) {
        // place this value into create event info model
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(emailNode);
      },
    );
  }

  // Textfield input for Contact Email
  Widget _buildEventContactEmail() {
    return TextInput(
      decoration: InputDecoration(
          labelText: 'Email Address*', border: OutlineInputBorder()),
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
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
      decoration: InputDecoration(
          labelText: 'Email Address*', border: OutlineInputBorder()),
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onChanged: (value) {
        // place this value into create event info model
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(titleNode);
      },
    );
  }

  // Data Picker widget
  Widget _buildEventDate() {
    // look for this calendar widget Ashvin talked about
    return null;
  }

  // Time Picker widget
  Widget _buildEventTime() {
    // figure about how to handle this
    // Picker or text field
    return null;
  }
}
