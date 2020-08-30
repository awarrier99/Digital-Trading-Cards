import 'package:flutter/material.dart';

import './EducationInputs.dart';

class SubForm extends StatefulWidget {
  final String subTitle;
  final int index;
  final Function callback;

  SubForm(this.subTitle, this.index, this.callback);

  @override
  _SubFormState createState() => _SubFormState();
}

class _SubFormState extends State<SubForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('${widget.subTitle} #${widget.index}'),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              widget.callback();
            },
          ),
        ]),
        EducationInputs(),
      ],
    );
  }
}
