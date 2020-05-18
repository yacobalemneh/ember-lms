import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';

class CourseCard extends StatelessWidget {
  final String courseName;
  final String instructorName;
  final String numberOfStudents;

  final String grade;

  final Function onPressed;

  CourseCard({this.instructorName, this.onPressed, this.courseName, this.numberOfStudents, this.grade});

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
                  'Course Name: $courseName',
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
              'Grade: $grade',
              style: TextStyle(
                  color: Colors.blue, fontSize: 13, fontFamily: 'Avenir Next'),
            ),

            Text(
              'Number of Students: $numberOfStudents',
              style: TextStyle(
                  color: Colors.blue, fontSize: 13, fontFamily: 'Avenir Next'),
            ),

            instructorName == null ?

            Text(
              'Instructor not Assigned',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontFamily: 'Avenir Next'),
            ):
            Text(
              'Instructor: $instructorName',
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
