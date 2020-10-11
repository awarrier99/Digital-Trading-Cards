import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/palette.dart';

class AddCardByEmail extends StatefulWidget {
  @override
  _AddCardByEmailState createState() => _AddCardByEmailState();
}

class _AddCardByEmailState extends State<AddCardByEmail> {
  final emailInputController = TextEditingController();

  Future addByEmailPreview(context) async {
    // Navigator.of(context).pushNamed('/addCardByEmail');
  }

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
    } else {
      final globalModel = context.read<GlobalModel>();
      final userModel = globalModel.userModel;

      // .fromJson() takes a mao as a param
      if (userModel.fromJson() != null) {
      } else {
        // if the username/email does not exist then return this
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          message: "Email does not not exist",
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          backgroundColor: Color(0xffDF360E),
        )..show(context);
      }
      // if the text input is not empty, then go through the database
      // if user does not exist => send a flush bar saying user not found
      // if a user does exist => send a preview of card associated with email
    }
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
