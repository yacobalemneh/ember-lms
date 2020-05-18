import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class GradeLevelListItem extends StatelessWidget {
  final String gradeLevel;
  final String listItemActionDescription;

  final Function onPressed;

  GradeLevelListItem({this.gradeLevel, this.listItemActionDescription,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: FlatButton(
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  '$gradeLevel',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Avenir Next'),
                ),
                Text(
                  listItemActionDescription,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontFamily: 'Avenir Next'),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                ),
              ],
            ),

            Divider(
              color: Colors.black,
              height: 0,
              thickness: 0.1,
              indent: 1,
            ),
          ],
        ),
      ),
    );
  }
}
