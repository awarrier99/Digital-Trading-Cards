import 'package:flutter/material.dart';

class InterestsInputs extends StatelessWidget {
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
        ),
      ],
    );
  }
}
