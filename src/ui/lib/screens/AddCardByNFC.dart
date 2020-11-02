import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/palette.dart';

class AddCardByNFC extends StatefulWidget {
  @override
  _AddCardByNFCState createState() => _AddCardByNFCState();
}

class _AddCardByNFCState extends State<AddCardByNFC> {
  @override
  void initState() {
    super.initState();
    final globalModel = context.read<GlobalModel>();
    final nfcModel = globalModel.nfcModel;
    final userModel = globalModel.userModel;
    nfcModel.addUser(userModel.currentUser.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Card By NFC Tap',
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
              Image.asset('lib/assets/images/addCardByNFC.png'),
              SizedBox(height: 20),
              Text(
                'Searching for Card',
                style: TextStyle(
                  color: Palette.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  shadowColor: Palette.secondary,
                  color: Palette.secondary,
                  elevation: 7,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Cancel',
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
