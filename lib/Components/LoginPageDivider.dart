import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class LoginPageDivider extends StatelessWidget {

  final String placeHolder;

  final Color color;

  LoginPageDivider({this.placeHolder, this.color});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 344.0,
      padding: EdgeInsets.only(top: 30.0),
      child: Row(
        children: [
          Expanded(
              child: Divider(
                color: color == null ? kThemeShadeOfBlack : color,
                height: 10,
                thickness: 0.2,
                endIndent: 22,
                )
              ),
          Text(
            placeHolder,
            style: TextStyle(
              fontSize: 15.0,
              fontFamily:  'Lato',
              color: color == null ? kThemeShadeOfBlack : color,
              ),
            ),
          Expanded(
              child: Divider(
                color: color == null ? kThemeShadeOfBlack : color,
                height: 10,
                thickness: 0.2,
                indent: 22,
                )
              )
        ],
        ),
    );
  }
}
