import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/Global.dart';

import '../SizeConfig.dart';
import '../palette.dart';

class Profile extends StatelessWidget {
  Future logout(BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(60),
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.account_circle,
                size: 256,
              ),
            ),
            SizedBox(
                child: RaisedButton(
                    child: Text('Logout'),
                    textColor: Colors.white,
                    color: Palette.primary,
                    onPressed: () {
                      final globalModel = context.read<GlobalModel>();
                      globalModel.logout();
                      logout(context);
                    }))
          ],
        ),
      ),
    );
  }
}
