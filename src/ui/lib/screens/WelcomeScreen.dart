import 'package:flutter/material.dart';
import 'package:ui/palette.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/screens/CreateCard1.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future createAccount(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateCard1()));
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
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              obscureText: true,
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
                                      //logIn(context);
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
