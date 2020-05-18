import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/ThemeButton.dart';

class WebPageTabBar extends StatelessWidget {

  final Function signInPressed;
  final Function signUpPressed;

  WebPageTabBar({this.signInPressed, this.signUpPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(11)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            // offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      height: 70,
      width: getDeviceWidth(context) * 90/100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 10.67),
            child: Text(
              'Dashboard',
              style: kThemeTextStyle,
              ),
            ),
          Image.asset('assets/appIcon.png'),
        ],
      ),
    );
  }
}
