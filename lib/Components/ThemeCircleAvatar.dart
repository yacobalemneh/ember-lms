import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class ThemeCircleAvatar extends StatelessWidget {

  final double radius;
  final String userName;
  final String image;

  ThemeCircleAvatar({this.radius = 25, this.userName, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        radius: radius,
        backgroundColor: kThemeOrangeFinal,
        backgroundImage: image != null ? NetworkImage(image) : null,
        child: image != null ? null : Text(userName[0], style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Lato'),),
      ),
    );
  }
}
