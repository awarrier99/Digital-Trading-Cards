import 'package:flutter/material.dart';
// import 'package:flushbar/flushbar.dart';
import 'package:ui/palette.dart';

class AddCard2 extends StatefulWidget {
  @override
  _AddCard2State createState() => _AddCard2State();
}

class _AddCard2State extends State<AddCard2> {
  final textInputController = TextEditingController();

  bool checkExistingUsers(String input) {
    return true;
  }

  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
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
              Image.asset('lib/assets/images/addCard2.png'),
              SizedBox(height: 60),
              Text(
                'Enter an Email',
                style: TextStyle(
                  color: Palette.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 50),
              TextField(
                controller: textInputController,
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                  height: 40,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Palette.primary,
                    color: Palette.primary,
                    elevation: 7,
                    child: GestureDetector(
                      onTap: () {
                        // if the input matches someone in the DB
                        if (checkExistingUsers(textInputController.text)) {
                          //go to new screen
                        }
                      },
                      child: Center(
                        child: Text(
                          'Search',
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
      ),
    );
  }
}
