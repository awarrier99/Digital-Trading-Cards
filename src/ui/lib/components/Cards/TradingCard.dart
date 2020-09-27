import 'package:flutter/material.dart';
import 'package:ui/components/BadgeGroup.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/palette.dart';

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
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xfff4f4f4), Color(0xfff8f8f8)],
              begin: Alignment.centerLeft,
              end: Alignment.center),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: new Color(0xffD1D9E6),
              spreadRadius: 10,
              blurRadius: 30,
              offset: Offset(10, 10),
            )
          ]),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            FlatButton(
              textColor: Colors.grey,
              onPressed: () => Navigator.of(context).pushNamed('/createCard1'),
              child: Column(
                children: [
                  Icon(
                    Icons.edit,
                  ),
                  Text(
                    "Edit Card",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.data.user.firstName + " " + widget.data.user.lastName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24, height: .5),
              ),
            ],
          ),

          // Container for main card information
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Education
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      !widget.data.education.isEmpty
                          ? Text(widget.data.education[0].institution.name)
                          : Text("none"),
                      // widget.data.education[0].field
                      // widget.data.education[0].endDate
                      // Text("Georgia Tech",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w600, fontSize: 16)),
                      // Text("Computer Science", style: TextStyle(fontSize: 16)),
                      // Text("Fall 2020",
                      //     style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),

                // Work
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Industry Experience",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Palette.darkGreen)),
                      // widget.data.work[0].jobTitle
                      // widget.data.work[0].company
                      Text("Software Development Intern",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Text("GTRI", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),

                // Volunteer
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Volunteering",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Palette.darkGreen)),
                      // widget.data.volunteering[0].title
                      // widget.data.volunteering[0].company
                      Text("Fundraising Organizer",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Text("Girls Who Code", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),

                // Skills
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Skills",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      BadgeGroup([
                        "Web Development",
                        "Data Science",
                        "UX Design",
                      ], "skills"),
                    ],
                  ),
                ),

                // Interests
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Interests",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      BadgeGroup(["Travel", "Education"], "interests"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
