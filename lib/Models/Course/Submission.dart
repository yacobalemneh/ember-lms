import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';

class Submission {
  String studentId;
  String studentName;
  DateTime submissionTime;
  String submissionTyped;
  String submittedFile;
  String assignmentID;
  String assignmentName;
  DateTime dueDate;
  double possibleGrade;
  double receivedGrade;

  DateTime studentSubmissionTime;

  bool isStudentOnTime;

  String submittedFileName;

  String instructorComments;

  DocumentReference studentDocument;

  Submission(
      {this.studentName,
        this.studentSubmissionTime,
        this.submissionTyped,
        this.isStudentOnTime,
      this.submittedFileName,
      this.instructorComments,
      this.studentId,
      this.submittedFile,
      this.dueDate,
      this.assignmentID,
      this.possibleGrade,
      this.assignmentName,
      this.receivedGrade,
      this.studentDocument}) {
    this.submissionTime = DateTime.now();
  }

  toMap() {
    return {
      'student_name': studentName,
      'student_id': studentId,
      'submission_typed' : submissionTyped,
      'submitted_file': submittedFile,
      'student_document': studentDocument,
      'assignment_id': assignmentID,
      'assignment_name': assignmentName,
      'due': dueDate,
      'possible_grade': possibleGrade,
      'received_grade': receivedGrade,
      'submission_time': submissionTime,
      'on_time': submissionTime.isAfter(dueDate) ? false : true,
      'instructor_comments': instructorComments,
      'submitted_file_name': submittedFileName,
    };
  }

  fromMap(var submission) {
    return Submission(
      studentName: submission['student_name'],
      studentId: submission['student_id'],
      submittedFile: submission['submitted_file'],
      submissionTyped: submission['submission_typed'],
      studentDocument: submission['student_document'],
      assignmentID: submission['assignment_id'],
      assignmentName: submission['assignment_name'],
      dueDate: submission['due'].toDate(),
      possibleGrade: submission['possible_grade'] != null ? submission['possible_grade'].toDouble() : null,
      receivedGrade: submission['received_grade'] != null ? submission['received_grade'].toDouble() : null,
      studentSubmissionTime: submission['submission_time'].toDate(),
      isStudentOnTime: submission['on_time'],
      instructorComments: submission['instructor_comments'],
      submittedFileName: submission['submitted_file_name'],
    );

  }

  Future<List<Submission>> getUserSubmissions(Class forClass, User forUser, Assignment forAssignment) async {
    var submissions = await FirebaseDB.getSubmissionsForStudent(forClass, forUser, forAssignment);

    var submissionDocuments = submissions.docs;

    List<Submission> studentSubmissions = [];

    for(var submission in submissionDocuments)
      studentSubmissions.add(fromMap(submission.data()));

    return studentSubmissions;
  }
}
