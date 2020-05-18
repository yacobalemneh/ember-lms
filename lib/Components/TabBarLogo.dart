import 'package:ember/IconHandler.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';


class TabBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: [
          IconHandler.orangeLogo,
         //kThemeTitle
        ],
      ),
    );
  }
}
