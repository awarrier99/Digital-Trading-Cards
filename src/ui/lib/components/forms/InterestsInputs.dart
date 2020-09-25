import 'package:flutter/material.dart';

import '../../models/CardInfo.dart';

class InterestsInputs extends StatelessWidget {
  final Interest model;

  InterestsInputs({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          autofocus: true,
          textInputAction: TextInputAction.done,
          decoration:
              InputDecoration(hintText: 'Name', border: OutlineInputBorder()),
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if (value.isEmpty) {
              return 'Required';
            }
            return null;
          },
          onChanged: (value) {
            model.title = value;
          }
        ),
      ],
    );
  }
}
