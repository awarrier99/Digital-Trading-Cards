import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:ui/components/forms/EventInputs.dart';

class AddEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Add New Event',
            style: TextStyle(fontFamily: 'Montserrat'),
          )),
      body: EventInputs(),
    );
  }
}
