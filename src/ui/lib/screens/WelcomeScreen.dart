import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/screens/Home.dart';
import '../components/RoundedButton.dart';

import '../models/User.dart';
import '../palette.dart';
import 'package:flushbar/flushbar.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FocusNode passwordNode = FocusNode();
  final User model = new User();
  bool _isThinking = false;

  Future createAccount(context) async {
    Navigator.of(context).pushNamed('/createAccount');
  }

  Future loginContext(context) async {
    Navigator.of(context).pushNamed('/main');
  }

  void login(BuildContext context) {
    setState(() {
      _isThinking = true;
    });
    final globalModel = context.read<GlobalModel>();
    final userModel = globalModel.userModel;
    final cardInfoModel = globalModel.cardInfoModel;
    userModel.updateUser(model);
    userModel.login().then((success) {
      setState(() {
        _isThinking = false;
      });
      if (success) {
        final user = userModel.currentUser;
        cardInfoModel.updateUser(user);
        loginContext(context);
      } else {
        throw (Error());
      }
    }).catchError((error) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        title: "Incorrect email or password",
        message: "Please double-check and try again!",
        duration: Duration(seconds: 5),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        backgroundColor: Color(0xffDF360E),
      )..show(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        key: _scaffoldKey,
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
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Palette.secondary),
                      ),
                    )),
                    Container(
                        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            TextInput(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                model.username = value;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(passwordNode);
                              },
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                            ),
                            SizedBox(height: 20),
                            TextInput(
                              focusNode: passwordNode,
                              obscureText: true,
                              onChanged: (value) {
                                model.password = value;
                              },
                              onEditingComplete: () {
                                login(context);
                              },
                              decoration: InputDecoration(
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                            ),
                            SizedBox(height: 40),
                            RoundedButton('LOGIN', Palette.primary, () {
                              if (!_isThinking) {
                                login(context);
                              }
                            }, _isThinking),
                            SizedBox(height: 20),
                            RoundedButton(
                              'CREATE ACCOUNT',
                              Palette.secondary,
                              () => createAccount(context),
                              false,
                            ),
                          ],
                        ))
                  ],
                ))));
  }
}
