import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/Global.dart';

import '../SizeConfig.dart';
import '../palette.dart';

class CreateSkillDialog extends StatefulWidget {
  final String title;

  CreateSkillDialog(this.title);

  @override
  CreateSkillDialogState createState() => CreateSkillDialogState();
}

class CreateSkillDialogState extends State<CreateSkillDialog> {
  final FocusNode titleNode = FocusNode();
  final _createSkillFormKey = GlobalKey<FormState>();
  final Skill model = new Skill();

  @override
  void initState() {
    super.initState();
    model.title = widget.title;
  }

  Future<void> _onAdd() async {
    try {
      final globalModel = context.read<GlobalModel>();
      await globalModel.onAdd('/api/skills', model, context);
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
          'Add New Skill',
          style: TextStyle(fontFamily: 'Montserrat'),
        )),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Form(
                key: _createSkillFormKey,
                child: Column(children: [
                  TextInput(
                      focusNode: titleNode,
                      decoration: InputDecoration(
                          labelText: 'Title*', border: OutlineInputBorder()),
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
                      child: Text('Add Skill'),
                      textColor: Colors.white,
                      color: Palette.primary,
                      onPressed: () {
                        if (_createSkillFormKey.currentState.validate()) {
                          _onAdd();
                        }
                      })
                ]))));
  }
}
