import 'package:flutter/material.dart';
import 'package:ui/components/BadgeGroup.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:ui/models/Global.dart';
import 'package:ui/palette.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/CardInfo.dart';
import 'package:provider/provider.dart';
import 'package:ui/models/User.dart';

// Widget to display a user's Trading Card that will be shown to other users
// User has the ability to edit the information in this card

class TradingCard extends StatefulWidget {
  CardInfo data;
  bool currentUser;

  TradingCard(this.data, {this.currentUser = false});

  @override
  _TradingCardState createState() => _TradingCardState();
}

class _TradingCardState extends State<TradingCard> {
  @override
  void initState() {
    super.initState();
    print(widget.data.toJson());
  }

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
              onPressed: () {
                final globalModel = context.read<GlobalModel>();
                globalModel.cardInfoModel.isEditing = true;
                Navigator.of(context).pushNamed('/createCard1');
              },
              child: widget.currentUser
                  ? Column(
                      children: [
                        Icon(
                          Icons.edit,
                        ),
                        Text(
                          "Edit Card",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.data.user.firstName} ${widget.data.user.lastName}',
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
                widget.data.education.isNotEmpty
                    ? (Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.data.education.map((e) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      e.institution.longName ??
                                          e.institution.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  Text('${e.degree} ${e.field.name}')
                                ],
                              );
                            }).toList()),
                      ))
                    : SizedBox.shrink(),
                // Work
                widget.data.work.isNotEmpty
                    ? (Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.data.work.map((e) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Industry Experience",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Palette.darkGreen)),
                                  Text(e.jobTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  Text(e.company.name,
                                      style: TextStyle(fontSize: 16)),
                                ],
                              );
                            }).toList()),
                      ))
                    : SizedBox.shrink(),
                // Volunteer
                widget.data.volunteering.isNotEmpty
                    ? (Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.data.volunteering.map((e) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Volunteering",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Palette.darkGreen)),
                                  Text(e.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  Text(e.company.name,
                                      style: TextStyle(fontSize: 16)),
                                ],
                              );
                            }).toList()),
                      ))
                    : SizedBox.shrink(),
                // Skills
                widget.data.skills.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Skills",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            BadgeGroup(
                                widget.data.skills
                                    .map((e) => e.skill.title)
                                    .toList(),
                                "skills"),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),

                // Interests
                widget.data.interests.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Interests",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            BadgeGroup(
                                widget.data.interests
                                    .map((e) => e.interest.title)
                                    .toList(),
                                "interests"),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
