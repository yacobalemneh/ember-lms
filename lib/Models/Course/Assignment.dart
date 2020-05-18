
import 'package:ember/Models/Course/Submission.dart';
import 'package:flutter/material.dart';

class Assignment {

  DateTime due;
  DateTime createdOn;
  String assignment;

  double possibleGrade;
  String instructions;



  String url;

  String assignmentDocId;

  List<dynamic> submittedby = [];

  Assignment({this.assignment, this.possibleGrade, this.due, this.instructions, this.submittedby, this.url, this.assignmentDocId}) {
    this.createdOn = DateTime.now();
  }


  toMap() {
    return {
      'assignment' : assignment,
      'instructions' : instructions,
      'due' : due,
      'created_on' : createdOn,
      'possible_grade' : possibleGrade,
      'submitted_by' : submittedby,
      'url' : url,
    };

  }
  static fromMap(var assignment) {
    return Assignment(
      assignment: assignment['assignment'],
      instructions: assignment['instructions'],
      due: assignment['due'].toDate(),
      submittedby: assignment['submitted_by'],
      possibleGrade: assignment['possible_grade'].toDouble(),
      url: assignment['url']
    );
  }






}

