import 'package:flutter/material.dart';

// This widget is used to display skills, and areas of interest on our
// SummaryCard.dart and TradingCard.dart in the form of a rectangle with
// round edges and a color gradient on it.

class BadgeColors {
  final Color startColor;
  final Color endColor;
  BadgeColors(this.startColor, this.endColor);
}

class ColorBadge extends StatelessWidget {
  final String text;
  final String badgeType;
  final double fontSize;

  final Map<String, BadgeColors> _colors = {
    "skills": BadgeColors(Color(0xff56D4D4), Colors.blue),
    "interests": BadgeColors(Color(0xff8098EF), Color(0xffE080F0))
  };

  ColorBadge(this.text, this.badgeType, {this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _colors[badgeType].startColor,
              _colors[badgeType].endColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: fontSize,
                  ),
                )),
          ],
        ));
  }
}
