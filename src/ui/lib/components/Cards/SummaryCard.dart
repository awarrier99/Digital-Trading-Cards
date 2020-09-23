import 'package:flutter/material.dart';

class SummaryCard extends StatefulWidget {
  final String fullName;
  final String school;
  final String degreeType;
  final String major;
  final List<String> skills;
  final List<String> interests;
  bool isFavorite;

  SummaryCard(this.fullName, this.school, this.degreeType, this.major,
      this.skills, this.interests, this.isFavorite);

  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Container(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
        decoration: BoxDecoration(
          color: Colors.grey,
          gradient: RadialGradient(
            center: Alignment(0.6, 2.0),
            radius: 10,
            colors: [Colors.white, Colors.grey[600],],
          ),
        ),
        child: Column(
          children: [

            // Row for the name and the favorite star indicator icon
            Row(
              children: [
                Text(widget.fullName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Spacer(),
                Icon(widget.isFavorite ? Icons.star : Icons.star_border),
              ],
            ),

            // Container for the college
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(widget.school,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ),

            // Container for the major
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(widget.degreeType,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(" "),
                  Text(widget.major,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
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
                  for (var skill in widget.skills)
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blueGrey, Colors.blue,],
                              stops: [-0.5, 1,],
                            ),
                          ),
                          child: Text(skill,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                  for (var skill in widget.interests)
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.purple[300], Colors.purple[100],],
                              stops: [-0.5, 1,],
                            ),
                          ),
                          child: Text(skill,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}