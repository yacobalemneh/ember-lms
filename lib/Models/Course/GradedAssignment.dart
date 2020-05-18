import 'package:ember/Database/all.dart';

class GradedAssignment {
  double possibleGrade;
  double receivedGrade;

  String assignmentName;
  DateTime due;

  String assignmentId;

  String studentName;

  String studentId;

  String instructorComments;

  DocumentReference studentDocument;

  GradedAssignment(
      {this.possibleGrade,
      this.receivedGrade,
        this.instructorComments,
      this.assignmentName,
      this.due,
      this.assignmentId,
      this.studentDocument,
      this.studentId,
      this.studentName});

  toMap() {
    return {
      'possible_grade' : possibleGrade,
      'received_grade' : receivedGrade,
      'assignment_name' : assignmentName,
      'due' : due,
      'assignment_id' : assignmentId,
      'student_document' : studentDocument,
      'student_id' : studentId,
      'student_name' :studentName,
      'instructor_comments' : instructorComments,
    };
  }


}
