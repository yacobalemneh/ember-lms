import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class AssignmentBanner extends StatelessWidget {

  final String title;
  final String description;
  final String submissionMessage;
  final bool submitted;

  AssignmentBanner({this.title, this.description, this.submitted, this.submissionMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: kThemeTextColor,
              fontFamily: 'Lato',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                description,
                style: TextStyle(
                  color: kThemeDescriptioncolor,
                  fontFamily: 'Lato',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              submissionMessage != null ?
              Row(
                children: [
                  Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    color: kThemeGreen,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Text(
                    submissionMessage,
                    style: TextStyle(
                      color: kThemeGreen,
                      fontFamily: 'Lato',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ):
              SizedBox()
            ],
          )
        ],
      ),
    );
  }
}
