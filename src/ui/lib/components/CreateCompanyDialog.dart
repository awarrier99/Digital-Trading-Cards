import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/components/TextInput.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/Global.dart';

import '../SizeConfig.dart';
import '../palette.dart';

class CreateCompanyDialog extends StatefulWidget {
  final String name;

  CreateCompanyDialog(this.name);

  @override
  CreateCompanyDialogState createState() => CreateCompanyDialogState();
}

class CreateCompanyDialogState extends State<CreateCompanyDialog> {
  final FocusNode titleNode = FocusNode();
  final _createCompanyFormKey = GlobalKey<FormState>();
  final Company model = new Company();

  @override
  void initState() {
    super.initState();
    model.name = widget.name;
  }

  Future<void> _onAdd() async {
    try {
      final globalModel = context.read<GlobalModel>();
      await globalModel.onAdd('/api/companies', model, context);
    } catch (err) {
      print('An error occurred while trying to add a new company:');
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Add New Company',
              style: TextStyle(fontFamily: 'Montserrat'),
            )),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Form(
                key: _createCompanyFormKey,
                child: Column(children: [
                  TextInput(
                      focusNode: titleNode,
                      decoration: InputDecoration(
                          labelText: 'Title*',
                          border: OutlineInputBorder()),
                      initialValue: widget.name,
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
                      child: Text('Add Company'),
                      textColor: Colors.white,
                      color: Palette.primaryGreen,
                      onPressed: () {
                        if (_createCompanyFormKey.currentState.validate()) {
                          _onAdd();
                        }
                      })
                ]))));
  }
}
