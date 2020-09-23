import 'package:flutter/material.dart';

import 'package:ui/SizeConfig.dart';
import 'package:ui/components/forms/ColorBadge.dart';

import 'package:ui/palette.dart';

import 'SubForm.dart';
import '../inheritedWidgets/SubFormInheritedWidget.dart';

class DynamicForm extends StatefulWidget {
  final String title;
  final Function inputBuilder;
  final List dynamicModelList;
  final Function dynamicModelBuilder;

  DynamicForm({
    @required this.title,
    @required this.inputBuilder,
    this.dynamicModelList,
    this.dynamicModelBuilder
  });

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  int index = 0;
  final _formKey = GlobalKey<FormState>();

  callback() {
    setState(() {
      index--;
      widget.dynamicModelList.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new SubFormInheritedWidget(
        inputBuilder: widget.inputBuilder,
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
                    SubForm(
                      subTitle: widget.title,
                      index: (i + 1),
                      callback: callback,
                      subModel: widget.dynamicModelList[i],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        onPressed: () {
                          //Add new form
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              index++;
                              widget.dynamicModelList.add(widget.dynamicModelBuilder());
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
