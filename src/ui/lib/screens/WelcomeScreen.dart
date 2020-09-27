import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/screens/Home.dart';

import '../models/User.dart';
import '../palette.dart';

class WelcomeScreen extends StatefulWidget {
  final String title;

  WelcomeScreen({
    Key key,
    this.title = "Wisteria.",
  }) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FocusNode passwordNode = FocusNode();
  FocusNode usernameNode = FocusNode();
  final User model = new User();

  Future createAccount(context) async {
    Navigator.of(context).pushNamed('/createAccount');
  }

  Future loginContext(context) async {
    Navigator.of(context).pushNamed('/main');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(15, 200, 0, 0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                    )),
                    Container(
                        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                model.username = value;
                              },
                              onFieldSubmitted: (term) {
                                FocusScope.of(context)
                                    .requestFocus(usernameNode);
                              },
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                model.password = value;
                              },
                              onFieldSubmitted: (term) {
                                FocusScope.of(context)
                                    .requestFocus(passwordNode);
                              },
                              decoration: InputDecoration(
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                            ),
                            SizedBox(height: 40),
                            Container(
                                height: 40,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  shadowColor: Palette.primaryGreen,
                                  color: Palette.primaryGreen,
                                  elevation: 7,
                                  child: GestureDetector(
                                    onTap: () {
                                      final userModel =
                                          context.read<UserModel>();
                                      final cardInfoModel =
                                          context.read<CardInfoModel>();
                                      userModel.updateUser(model);
                                      userModel.login().then((user) {
                                        if (user != null) {
                                          cardInfoModel.updateUser(user);
                                          loginContext(context);
                                        }
                                      }).catchError((error) {
                                        print('Caught $error');
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(height: 20),
                            Container(
                                height: 40,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black87,
                                  elevation: 7,
                                  child: GestureDetector(
                                    onTap: () {
                                      createAccount(context);
                                    },
                                    child: Center(
                                      child: Text(
                                        'CREATE ACCOUNT',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ))
                  ],
                ))));
  }
}
