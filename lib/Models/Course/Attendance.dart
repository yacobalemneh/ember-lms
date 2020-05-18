

import 'package:ember/Database/all.dart';

class Attendance {

  String studentName;
  String studentId;

  DateTime date;

  DocumentReference studentDocument;

  String docID;

  bool present;


  Attendance({this.studentName, this.studentId, this.studentDocument, this.present}) {
    this.date = DateTime.now();
  }

  Attendance.fromDatabase({this.studentName, this.studentId, this.studentDocument, this.present, this.date, this.docID});


  toMap() {
    return {
      'student_name' : studentName,
      'student_id' : studentId,
      'date' : date,
      'student_document' : studentDocument,
      'present' : present,
    };
  }

  factory Attendance.fromSnapshot(snapshot) {
    return Attendance.fromDatabase(
      studentName: snapshot.data()['student_name'],
      studentId: snapshot.data()['student_id'],
      date: snapshot.data()['date'].toDate(),
      studentDocument: snapshot.data()['student_document'],
      present: snapshot.data()['present'],
      docID: snapshot.id,
    );
  }



}


class AttendanceRecord {
  
  DateTime recordDate;
  
  List<dynamic> presentList;

  List<dynamic> absentList;
  
  int totalStudents;
  
  int presentStudents;
  
  double percentPresent;

  String attendanceDocumentId;
  
  get ratio => this.presentStudents / this.totalStudents;


  getPercentString(double percent) {
    return ((percent * 100).round()).toString() +  '%';
  }

  markPresent({Attendance forAttendee}) {
    presentList.add(forAttendee.studentId);
    absentList.remove(forAttendee.studentId);
    this.presentStudents = presentList.length;
  }
  markAbsent({Attendance forAttendee}) {
    presentList.remove(forAttendee.studentId);
    absentList.add(forAttendee.studentId);
    this.presentStudents = presentList.length;
  }
  
  
  AttendanceRecord({this.recordDate, this.presentList, this.absentList, this.totalStudents, this.presentStudents, this.percentPresent});
  
  toMap() {
    return {
      'record_date' : recordDate,
      'present_list' : presentList,
      'absent_list' : absentList,
      'total_students' : totalStudents,
      'present_students' : presentStudents,
      'percent_present' : ratio,
    };
  }

  factory AttendanceRecord.fromJson(parsedJson) {
    return AttendanceRecord(
      recordDate: parsedJson['record_date'].toDate(),
      presentList: parsedJson['present_list'],
      absentList: parsedJson['absent_list'],
      totalStudents: parsedJson['total_students'],
      presentStudents: parsedJson['present_students'],
      percentPresent: parsedJson['percent_present'],
    );
  }
  
}