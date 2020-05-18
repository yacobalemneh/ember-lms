import 'package:flutter/material.dart';
import 'package:ember/constants.dart';


class ViewProfileCourseList extends StatelessWidget {

  final String className;

  final Function onDeletePressed;

  ViewProfileCourseList({this.className, this.onDeletePressed});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Table(
        children: [
              TableRow(
                children: [
                  Text(
                    className,
                    style: kThemeDescriptionTextStyle.copyWith(fontSize: 15),
                  ),
                  GestureDetector(
                    child: Icon(Icons.remove_circle, color: Colors.red,
                    ),
                    onTap: onDeletePressed
                  ),
                ]
              ),

        ],
      ),
    );
  }
}
