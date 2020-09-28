import 'package:flutter/material.dart';

class BadgeColors {
  final Color startColor;
  final Color endColor;
  BadgeColors(this.startColor, this.endColor);
}

class ColorBadgeSmall extends StatelessWidget {
  final String text;
  final String badgeType;

  final Map<String, BadgeColors> _colors = {
    "skills": BadgeColors(Color(0xff56D4D4), Colors.blue),
    "interests": BadgeColors(Color(0xff8098EF), Color(0xffE080F0))
  };

  ColorBadgeSmall(this.text, this.badgeType);

  @override
  Widget build(BuildContext context) {
    print(badgeType.runtimeType);
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
                    fontSize: 13),
              ),
            ),
          ],
        ));
  }
}
