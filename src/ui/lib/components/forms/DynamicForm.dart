import 'package:flutter/material.dart';

import 'package:ui/SizeConfig.dart';
import 'package:ui/components/forms/ColorBadge.dart';

import 'package:ui/palette.dart';

import 'SubForm.dart';
import '../inheretedwidgets/SubFormInheretedWidget.dart';

class DynamicForm extends StatefulWidget {
  final String title;
  final Widget inputs;

  DynamicForm(this.title, this.inputs);

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  int index = 0;
  final _formKey = GlobalKey<FormState>();

  callback() {
    setState(() {
      index--;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new SubFormInheretedWidget(
        inputs: widget.inputs,
        child: Container(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.2,
                          color: Palette.darkGreen),
                    ),
                  ]),
                  for (int i = 0; i < index; i++)
                    SubForm('${widget.title}', (i + 1), callback),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        onPressed: () {
                          //Add new form
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              index++;
                            }
                          });
                          return;
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text(
                              'Add ${widget.title}',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 3,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ]))));
  }
}
