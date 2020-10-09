import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/Global.dart';

import '../SizeConfig.dart';
import '../palette.dart';

class CreateFieldDialog extends StatefulWidget {
  final String abbreviation;

  CreateFieldDialog(this.abbreviation);

  @override
  CreateFieldDialogState createState() => CreateFieldDialogState();
}

class CreateFieldDialogState extends State<CreateFieldDialog> {
  final FocusNode abbreviationNode = FocusNode();
  final FocusNode nameNode = FocusNode();
  final _createFieldFormKey = GlobalKey<FormState>();
  final Field model = new Field();

  @override
  void initState() {
    super.initState();
    model.abbreviation = widget.abbreviation;
  }

  Future<void> _onAdd() async {
    try {
      final globalModel = context.read<GlobalModel>();
      await globalModel.onAdd('/api/fields', model, context);
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
          'Add New Field',
          style: TextStyle(fontFamily: 'Montserrat'),
        )),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Form(
                key: _createFieldFormKey,
                child: Column(children: [
                  TextInput(
                      focusNode: abbreviationNode,
                      decoration: InputDecoration(
                          labelText: 'Abbreviation*',
                          border: OutlineInputBorder()),
                      initialValue: widget.abbreviation,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        model.abbreviation = value;
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(nameNode);
                      }),
                  SizedBox(height: SizeConfig.safeBlockVertical * 2),
                  TextInput(
                      focusNode: nameNode,
                      decoration: InputDecoration(
                          labelText: 'Name*', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        model.name = value;
                      }),
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  RaisedButton(
                      child: Text('Add Field'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        if (_createFieldFormKey.currentState.validate()) {
                          _onAdd();
                        }
                      })
                ]))));
  }
}
