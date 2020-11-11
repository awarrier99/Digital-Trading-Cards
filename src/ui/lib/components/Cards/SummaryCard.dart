import 'package:flutter/material.dart';
import 'package:ui/components/BadgeGroup.dart';
import 'package:ui/models/CardInfo.dart';

// Tile summary format of a user's card in the view saved cards screen

class SummaryCard extends StatefulWidget {
  CardInfo data;
  bool currentUser;
  bool isFavorite = false;

  // final String fullName;
  // final String school;
  // final String degreeType;
  // final String major;
  // final List<String> skills;
  // final List<String> interests;
  // bool isFavorite;

  SummaryCard(this.data, {this.currentUser = false});

  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        gradient: RadialGradient(
          center: Alignment(0.6, 2.0),
          radius: 10,
          colors: [
            Colors.white,
            Colors.grey[600],
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          // Row for the name and the favorite star indicator icon
          Row(
            children: [
              Text(
                widget.data.user.firstName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey[700],
                ),
              ),
              Text(" "),
              Text(
                widget.data.user.lastName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey[700],
                ),
              ),
              Spacer(),
              Icon(
                widget.isFavorite ? Icons.star : Icons.star_border,
                color: widget.isFavorite ? Colors.amber : Colors.black,
              ),
            ],
          ),

          // Container for the college
          widget.data.education.isNotEmpty
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.data.education[0].institution.longName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                )
              : SizedBox.shrink(),

          // Container for the major
          widget.data.education.isNotEmpty
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 2.5, 0, 5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        widget.data.education[0].degree,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      // Text(" "),
                      // Text(
                      //   widget.major,
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.grey[700],
                      //   ),
                      // ),
                    ],
                  ),
                )
              : SizedBox.shrink(),

          // Container for the users skills
          widget.data.skills.isNotEmpty
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  height: 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      BadgeGroup(
                        widget.data.skills.map((e) => e.skill.title).toList(),
                        "skills",
                        fontSize: 13,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),

          // Container for the interests
          widget.data.interests.isNotEmpty
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  height: 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      BadgeGroup(
                        widget.data.interests
                            .map((e) => e.interest.title)
                            .toList(),
                        "interests",
                        fontSize: 13,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
