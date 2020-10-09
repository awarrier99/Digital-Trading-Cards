import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/Global.dart';

import '../SizeConfig.dart';
import '../palette.dart';

class CreateInterestDialog extends StatefulWidget {
  final String title;

  CreateInterestDialog(this.title);

  @override
  CreateInterestDialogState createState() => CreateInterestDialogState();
}

class CreateInterestDialogState extends State<CreateInterestDialog> {
  final FocusNode titleNode = FocusNode();
  final _createInterestFormKey = GlobalKey<FormState>();
  final Interest model = new Interest();

  @override
  void initState() {
    super.initState();
    model.title = widget.title;
  }

  Future<void> _onAdd() async {
    try {
      final globalModel = context.read<GlobalModel>();
      await globalModel.onAdd('/api/interests', model, context);
    } catch (err) {
      print('An error occurred while trying to add a new institution:');
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Add New Interest',
              style: TextStyle(fontFamily: 'Montserrat'),
            )),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Form(
                key: _createInterestFormKey,
                child: Column(children: [
                  TextInput(
                      focusNode: titleNode,
                      decoration: InputDecoration(
                          labelText: 'Title*',
                          border: OutlineInputBorder()),
                      initialValue: widget.title,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        model.title = value;
                      }),
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  RaisedButton(
                      child: Text('Add Interest'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        if (_createInterestFormKey.currentState.validate()) {
                          _onAdd();
                        }
                      })
                ]))));
  }
}
