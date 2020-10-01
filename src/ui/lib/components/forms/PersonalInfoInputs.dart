import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/components/forms/DropdownFormField.dart';
import 'package:ui/palette.dart';
import 'package:ui/SizeConfig.dart';

import '../../models/CardInfo.dart';
import '../../models/User.dart';

// Create a Form widget.
class PersonalInfoInputs extends StatefulWidget {
  final GlobalKey key;
  final User model;

  PersonalInfoInputs({@required this.key, @required this.model});

  @override
  PersonalInfoInputsState createState() {
    return PersonalInfoInputsState();
  }
}

class PersonalInfoInputsState extends State<PersonalInfoInputs> {
  // FocusNodes initialized for later use to change textField focus when the
  // user hits the continue button on the keyboard.
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode countryNode = FocusNode();
  FocusNode stateNode = FocusNode();
  FocusNode cityNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.model.type = 'Student';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.key,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: true,
                child: Text('Personal Information',
                    style: TextStyle(fontSize: 20, color: Palette.darkGreen)),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              TextInput(
                  decoration: InputDecoration(
                      labelText: 'First Name*', border: OutlineInputBorder()),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.model.firstName = value;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(lastNameNode);
                  }),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              TextInput(
                  focusNode: lastNameNode,
                  decoration: InputDecoration(
                      labelText: 'Last Name*', border: OutlineInputBorder()),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.model.lastName = value;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(emailNode);
                  }),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              TextInput(
                  focusNode: emailNode,
                  decoration: InputDecoration(
                      labelText: 'Email*', border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.model.username = value;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(countryNode);
                  }),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              TextInput(
                  focusNode: countryNode,
                  decoration: InputDecoration(
                      labelText: 'Country*', border: OutlineInputBorder()),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.model.country = value;
                  },
                  onEditingComplete: (term) {
                    FocusScope.of(context).requestFocus(stateNode);
                  }),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              TextInput(
                  focusNode: stateNode,
                  decoration: InputDecoration(
                      labelText: 'State*', border: OutlineInputBorder()),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.model.state = value;
                  },
                  onEditingComplete: (term) {
                    FocusScope.of(context).requestFocus(cityNode);
                  }),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              TextInput(
                  focusNode: cityNode,
                  decoration: InputDecoration(
                      labelText: 'City*', border: OutlineInputBorder()),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.model.city = value;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(passwordNode);
                  }),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              TextInput(
                  obscureText: true,
                  focusNode: passwordNode,
                  decoration: InputDecoration(
                      labelText: 'Password*', border: OutlineInputBorder()),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.model.password = value;
                  }),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'User Type*',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              DropdownFormField(
                ['Student', 'Recruiter'],
                onChanged: (value) {
                  widget.model.type = value;
                },
              )
            ]));
  }
}
