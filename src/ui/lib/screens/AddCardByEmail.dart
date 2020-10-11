import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:ui/palette.dart';

class AddCardByEmail extends StatefulWidget {
  @override
  _AddCardByEmailState createState() => _AddCardByEmailState();
}

class _AddCardByEmailState extends State<AddCardByEmail> {
  final emailInputController = TextEditingController();

  @override
  void dispose() {
    emailInputController.dispose();
    super.dispose();
  }

  void searchWithEmail() {
    if (emailInputController.text.isEmpty) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: "Invalid email input",
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        backgroundColor: Color(0xffDF360E),
      )..show(context);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Card By Email',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('lib/assets/images/addCardByEmail.png'),
              SizedBox(height: 20),
              Text(
                'Enter an email',
                style: TextStyle(
                  color: Palette.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextFormField(
                  controller: emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    searchWithEmail();
                  },
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
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
                      searchWithEmail();
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
