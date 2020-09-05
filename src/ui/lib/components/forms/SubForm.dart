import 'package:flutter/material.dart';

import './EducationInputs.dart';
import './ExperienceVolunteerInput.dart';
import './SkillsInputs.dart';
import './InterestsInputs.dart';

class SubForm extends StatefulWidget {
  final String subTitle;
  final int index;
  final Function callback;
  final String subFormID;

  SubForm(this.subTitle, this.index, this.callback, this.subFormID);

  @override
  _SubFormState createState() => _SubFormState();
}

class _SubFormState extends State<SubForm> {
  Widget getSubFormInput() {
    if (widget.subFormID == 'EducationInputs') {
      return EducationInputs();
    } else if (widget.subFormID == 'ExperienceVolunteerInput') {
      return ExperienceVolunteerInput();
    } else if (widget.subFormID == 'SkillsInputs') {
      return SkillsInputs();
    } else if (widget.subFormID == 'InterestsInputs') {
      return InterestsInputs();
    }
    return null;
  }

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
        getSubFormInput(),
      ],
    );
  }
}
