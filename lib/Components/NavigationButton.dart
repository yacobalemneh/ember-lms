import 'package:ember/constants.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {

  final String title;
  final Widget icon;
  final Function onPressed;


  NavigationButton({this.title, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: title != null ?
      Text(
        title,
        style: TextStyle(
          color: kThemeOrangeFinal,
          fontSize: 17,
          fontWeight: FontWeight.w500,
          fontFamily: 'Lato',
        ),
      ) :
         icon,
      onTap: onPressed,
    );
  }
}
