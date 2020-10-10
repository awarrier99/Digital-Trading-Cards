import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:ui/models/Global.dart';
import 'package:provider/provider.dart';
import '../palette.dart';
import 'package:ui/components/SearchBar.dart';

class AddCard extends StatelessWidget {
  const AddCard();

  Future addByEmail(context) async {
    // NOAH change this to new route / your page
    Navigator.of(context).pushNamed('/addCard2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Card',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('lib/assets/images/addCard.png'),
                SizedBox(height: 50),
                Text(
                  'Grow your network',
                  style: TextStyle(
                    color: Palette.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                    'Collect the cards of people you meet and build a stronger network',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.secondary,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                    margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                    height: 40,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Palette.primary,
                      color: Palette.primary,
                      elevation: 7,
                      child: GestureDetector(
                        onTap: () => addByEmail(context),
                        child: Center(
                          child: Text(
                            'Add by email',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
