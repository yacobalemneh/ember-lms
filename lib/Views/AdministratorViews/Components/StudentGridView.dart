import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class StudentGridView extends StatelessWidget {
  final String studentName;
  final String studentId;
  final String studentGrade;

  final Function onPressed;

  StudentGridView({this.studentName, this.onPressed, this.studentId, this.studentGrade});

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
                  studentName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Avenir Next'),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                ),
              ],
            ),
            Text(
              'Student ID: $studentId',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontFamily: 'Avenir Next'),
            ),
            studentGrade == null ?
            Text(
              'Grade: Not Assigned',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Avenir Next'),
            ) :
            Text(
              'Grade: $studentGrade',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontFamily: 'Avenir Next'),
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
