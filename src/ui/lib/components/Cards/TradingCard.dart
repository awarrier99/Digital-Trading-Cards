import 'package:flutter/material.dart';
import 'package:ui/models/CardInfo.dart';

// Widget to display a user's Trading Card that will be shown to other users
// User has the ability to edit the information in this card

class TradingCard extends StatefulWidget {
  CardInfo data;

  TradingCard(this.data);

  @override
  _TradingCardState createState() => _TradingCardState();
}

class _TradingCardState extends State<TradingCard> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Column(
        children: [
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // TODO: Route back to create card form
                },
              ),
              Text("edit card")
            ],
          ),
          Row(
            children: [
              Text(widget.data.user.firstName),
              Text(widget.data.user.lastName)
            ],
          ),
          Container(
            child: Column(
              children: [
                Text(widget.data.work[0].jobTitle),
                Text(widget.data.work[0].company.name),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(widget.data.education[0].institution.longName),
                Text(widget.data.education[0].degree),
              ],
            ),
          ),
          Text("Skills"), // TODO: Create a tag list widget
          Text("Interests"), // TODO: Create a tag list widget
        ],
      ),
    );
  }
}
