import 'package:flutter/material.dart';

import 'SubForm.dart';

class DynamicForm extends StatefulWidget {
  final String title;
  final String subformID;
  DynamicForm(this.title, this.subformID);

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  int index = 0;
  String test = 'EducationInputs';
  final _formKey = GlobalKey<FormState>();

  callback() {
    setState(() {
      index--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(widget.title,
                    style: TextStyle(fontSize: 20, color: Color(0xFF41B46F))),
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
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
              ]),
              for (int i = 0; i < index; i++)
                SubForm('${widget.title}', (i + 1), callback, widget.subformID),
            ])));
  }
}
