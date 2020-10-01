import 'package:flutter/material.dart';
import 'package:ui/components/TextInput.dart';

import '../../models/CardInfo.dart';

class InterestsInputs extends StatelessWidget {
  final UserInterest model;

  InterestsInputs({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextInput(
            autofocus: true,
            decoration:
                InputDecoration(hintText: 'Name', border: OutlineInputBorder()),
            textCapitalization: TextCapitalization.sentences,
            initialValue: model.interest?.title,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onChanged: (value) {
              model.interest.title = value;
            }),
      ],
    );
  }
}
