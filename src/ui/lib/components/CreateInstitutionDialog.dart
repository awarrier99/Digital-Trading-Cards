import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/Global.dart';

import '../SizeConfig.dart';
import '../palette.dart';

// This is a widget that allows the user to input a new institution into the
// autocomplete dropdown
class CreateInstitutionDialog extends StatefulWidget {
  final String name;

  CreateInstitutionDialog(this.name);

  @override
  CreateInstitutionDialogState createState() => CreateInstitutionDialogState();
}

class CreateInstitutionDialogState extends State<CreateInstitutionDialog> {
  final FocusNode nameNode = FocusNode();
  final FocusNode longNameNode = FocusNode();
  final _createInstitutionFormKey = GlobalKey<FormState>();
  final Institution model = new Institution();

  @override
  void initState() {
    super.initState();
    model.name = widget.name;
  }

  Future<void> _onAdd() async {
    try {
      final globalModel = context.read<GlobalModel>();
      await globalModel.onAdd('/api/institutions', model, context);
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
          'Add New Institution',
          style: TextStyle(fontFamily: 'Montserrat'),
        )),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Form(
                key: _createInstitutionFormKey,
                child: Column(children: [
                  TextInput(
                      focusNode: nameNode,
                      decoration: InputDecoration(
                          labelText: 'Name*', border: OutlineInputBorder()),
                      initialValue: widget.name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        model.name = value;
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(longNameNode);
                      }),
                  SizedBox(height: SizeConfig.safeBlockVertical * 2),
                  TextInput(
                      focusNode: longNameNode,
                      decoration: InputDecoration(
                          labelText: 'Long Name', border: OutlineInputBorder()),
                      onChanged: (value) {
                        model.longName = value;
                      }),
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  RaisedButton(
                      child: Text('Add Institution'),
                      textColor: Colors.white,
                      color: Palette.primary,
                      onPressed: () {
                        if (_createInstitutionFormKey.currentState.validate()) {
                          _onAdd();
                        }
                      })
                ]))));
  }
}
