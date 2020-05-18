import 'package:ember/constants.dart';
import 'package:flutter/material.dart';

class DescriptionBanner extends StatelessWidget {

  final String title;
  final String description;
  final String postedOn;

  DescriptionBanner({this.title, this.description, this.postedOn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 22, right: 35, top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'Lato',
              color: kThemeTextColor,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          postedOn != null ?
          Text(
            postedOn,
            style: kThemeDescriptionTextStyle,
          ) :
              SizedBox(),
          SizedBox(
            height: 6,
          ),
          Text(
            description,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
              fontFamily: 'Lato',
              color: kThemeTextColor,
            ),
          )
        ],
      ),
    );
  }
}
