import 'package:flutter/material.dart';
import 'package:ui/components/forms/ColorBadge.dart';
import 'package:ui/models/CardInfo.dart';

class SummaryCard extends StatefulWidget {
  CardInfo data;
  bool isFavorite = false;

  // final String fullName;
  // final String school;
  // final String degreeType;
  // final String major;
  // final List<String> skills;
  // final List<String> interests;
  // bool isFavorite;

  SummaryCard(this.data);

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
          Container(
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
          ),

          // Container for the major
          Container(
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
          ),

          // Container for the users skills
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var skill in widget.data.skills)
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: ColorBadge(skill.title, "skill"),
                  ),
              ],
            ),
          ),

          // Container for the interests
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var interest in widget.data.interests)
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: ColorBadge(interest.title, "interest"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
