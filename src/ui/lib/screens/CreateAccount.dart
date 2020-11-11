import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/models/User.dart';

import '../components/forms/PersonalInfoInputs.dart';
import '../SizeConfig.dart';
import '../palette.dart';
import '../components/RoundedButton.dart';

// UI screen for creating a new account
// Includes a form called PersonalInfoInputs

class CreateAccount extends StatelessWidget {
  final _personalInfoInputsKey = GlobalKey<FormState>();
  final _personalInfoInputsModel = User();

  Future nextStep(context) async {
    Navigator.of(context).pushNamed('/main');
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            child: Column(
              children: <Widget>[
                PersonalInfoInputs(
                  key: _personalInfoInputsKey,
                  model: _personalInfoInputsModel,
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 1),
                RoundedButton('Sign Up', Palette.primary, () {
                  if (_personalInfoInputsKey.currentState.validate()) {
                    final globalModel = context.read<GlobalModel>();
                    final userModel = globalModel.userModel;
                    final cardInfoModel = globalModel.cardInfoModel;
                    userModel.updateUser(_personalInfoInputsModel);
                    userModel.createUser().then((success) {
                      if (success)
                        cardInfoModel.updateUser(userModel.currentUser);
                    });
                    nextStep(context);
                  }
                }, false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
