import 'package:flutter/material.dart';
import 'package:ui/models/User.dart';

// This widget displays a list of names for the attendee's list in
// the ViewAttendees screen

class CardList extends StatefulWidget {
  final List<User> list;

  CardList(this.list);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          for (var item in widget.list)
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    '${item.firstName} ${item.lastName}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
