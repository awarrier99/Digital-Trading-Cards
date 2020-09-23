import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';

import 'DropdownFormField.dart';
import '../../models/CardInfo.dart';

class EducationInputs extends StatefulWidget {
  final Education model;

  EducationInputs({@required this.model});

  @override
  EducationInputsState createState() => EducationInputsState();
}

class EducationInputsState extends State<EducationInputs> {
  FocusNode majorNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            onChanged: (value) {
              widget.model.institution = Institution()
                  ..name = value;
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
          onChanged: (value) {
            widget.model.field = Field()
                ..name = value;
          },
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Degree Type*',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
        ),
        DropdownFormField(
          data: ['Associate', 'Bachelor\'s', 'Master\'s', 'Doctoral'],
          onChanged: (value) {
            widget.model.degree = value;
          },
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Graduation Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        Row(children: [
          DropdownFormField(
            data: ['Fall', 'Spring', 'Summer'],
            onChanged: (value) {

            },
          ),
          DropdownFormField(
            data: new List<String>.generate(10, (i) => (i + DateTime.now().year - 5).toString()),
            onChanged: (value) {

            },
          ),
        ])
      ],
    );
  }
}
