import 'package:flutter/material.dart';

import 'DropdownFormField.dart';
import 'package:ui/SizeConfig.dart';

class EducationInputs extends StatelessWidget {
  FocusNode majorNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: 'School*', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(majorNode);
            }),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        TextFormField(
          focusNode: majorNode,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              labelText: 'Major/Subject*', border: OutlineInputBorder()),
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if (value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Degree Type*',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        DropdownFormField(['Associates', 'Bachelors', 'Masters', 'PhD']),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Graduation Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        Row(children: [
          DropdownFormField(['Fall', 'Spring', 'Summer']),
          DropdownFormField(new List<String>.generate(
              10, (i) => (i + DateTime.now().year - 5).toString())),
        ])
      ],
    );
  }
}
