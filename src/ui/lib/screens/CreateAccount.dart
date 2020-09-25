import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Users.dart';

import '../models/CardInfo.dart';
import '../components/forms/PersonalInfoInputs.dart';
import '../SizeConfig.dart';
import '../palette.dart';
import 'Home.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CreateAccount extends StatelessWidget {
  final _personalInfoInputsKey = GlobalKey<FormState>();
  final _personalInfoInputsModel = User();

  Future nextStep(context) async {
    Navigator.of(context).pushNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Account',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Form(
                    child: Column(children: <Widget>[
              PersonalInfoInputs(
                key: _personalInfoInputsKey,
                model: _personalInfoInputsModel,
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 10),
              SizedBox(
                  child: RaisedButton(
                      child: Text('Sign Up'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        if (_personalInfoInputsKey.currentState.validate()) {
                          final userModel = context.read<UserModel>();
                          userModel.updateUser(_personalInfoInputsModel);
                          userModel.createUser();
                          print(userModel.currentuser.toJson());
                          nextStep(context);
                        }
                      }))
            ])))));
  }
}
