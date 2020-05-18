import 'package:ember/Database/FirebaseDB.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Helper/all.dart';


class InstructorOperations extends FirebaseDB {

  static updateClassDescription({Class forClass}) async {
    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    await classRef.update(forClass.toMap());
  }

  static deleteAnnouncement(Class forClass ,String announcementId) {
    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    classRef.collection('announcements').doc(announcementId).delete();
  }

  static addAnnouncement(Class forClass, Announcement announcement) async {
    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    classRef.collection('announcements').doc().set(announcement.toMap());

  }

  static getAnnouncements(Class forClass) {

    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    return classRef.collection('announcements').orderBy('date', descending: true).snapshots();

  }

  static addFileToClass(Class forClass, CourseFile file) {
    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    classRef.collection('files').doc().set(file.toMap());
  }

  static deleteFile(Class forClass, String fileID) {
    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    classRef.collection('files').doc(fileID).delete();
  }

  static addLectureNotes(Class forClass, CourseFile file) {
    addFileToClass(forClass, file);
    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    classRef.collection('lecture_notes').doc().set(file.toMap());
  }


  static deleteLectureNote(Class forClass, String lectureNoteId) {
    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    classRef.collection('lecture_notes').doc(lectureNoteId).delete();
  }

  static addVideoForClass(Class forClass, Video video) {
    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    classRef.collection('videos').doc().set(video.toMap());
  }

  static deleteVideoFromClass(Class forClass, String videoID) {
    var classRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
    classRef.collection('videos').doc(videoID).delete();
  }

  static createAssignment(Class forClass, Assignment assignment) {
    var classRef = FirebaseDB.subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .collection('assignments');
    classRef.add(assignment.toMap());
  }

  static createAssignmentWithFile({Class forClass, Assignment thisAssignment, CourseFile withFile}) async {

    await FirebaseDB.dbInstance.runTransaction((transaction) async {

      var filesRef = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className);
      filesRef.collection('files').doc().set(withFile.toMap());

      var assignmentRef = FirebaseDB.subjects
          .doc(forClass.subject)
          .collection('classes')
          .doc(forClass.className)
          .collection('assignments');
      assignmentRef.add(thisAssignment.toMap());

    });
  }

  static getStudentsInClass({Class forClass, bool rawData = true}) async {

    var classRef = await FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className).get();
    var studentsInClass = classRef.data()['students'];

    List<dynamic> students = [];
    List<User> studentUser = [];

    for(var student in studentsInClass) {
      students.add(await student.get());
    }

    if(rawData == true) {
      return students;
    }
    else {
      for (var i = 0; i < students.length; i++) {
        studentUser.add(User.fromMap(students[i].data()));
        studentUser[i].userDocument = students[i].reference;
      }
      return studentUser;
    }

  }


  static recordAttendance({Class forClass, List<Attendance> studentAttendees}) async {

    FirebaseDB.dbInstance.runTransaction((transaction) async {

      String attendanceDocId;

      var attendanceDoc = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className).collection('term_attendance');

      List<User> studentsInClass = await getStudentsInClass(forClass: forClass, rawData: false);


      AttendanceRecord attendanceRecord = AttendanceRecord(
        recordDate: DateTime.now(),
        presentList: [],
        absentList: [],
        totalStudents: studentsInClass.length,
        presentStudents: 0,
      );
      
      await attendanceDoc.add(attendanceRecord.toMap()).then((value) => attendanceDocId = value.id);

      List<Attendance> attendanceForDay = [];

      for(var student in studentsInClass) {
        for(var attendee in studentAttendees) {
          if(student.userId == attendee.studentId && attendee.present != false) {
            attendanceRecord.presentList.add(student.userId);
            attendanceRecord.presentStudents = attendanceRecord.presentList.length;
            attendanceForDay.add(Attendance(
              studentName: student.fullName,
              studentId: student.userId,
              studentDocument: student.userDocument,
              present: true,
            ));

            await attendanceDoc.doc(attendanceDocId).update(attendanceRecord.toMap());
          }
          else if(student.userId == attendee.studentId && attendee.present == false) {
            attendanceRecord.absentList.add(student.userId);
            attendanceForDay.add(Attendance(
              studentName: student.fullName,
              studentId: student.userId,
              studentDocument: student.userDocument,
              present: false,
            ));
            await attendanceDoc.doc(attendanceDocId).update(attendanceRecord.toMap());

          }
          // else

        }
        if(!attendanceRecord.absentList.contains(student.userId) && !attendanceRecord.presentList.contains(student.userId)) {
          attendanceRecord.absentList.add(student.userId);
          attendanceForDay.add(Attendance(
            studentName: student.fullName,
            studentId: student.userId,
            studentDocument: student.userDocument,
            present: false,
          ));
          await attendanceDoc.doc(attendanceDocId).update(attendanceRecord.toMap());
        }
      }
      var attendanceForDayCollection = attendanceDoc.doc(attendanceDocId).collection('day_attendance');

      for(var attendee in attendanceForDay) {
        await attendanceForDayCollection.add(attendee.toMap());
      }
      
    });
  }

  static updateAttendanceForStudent({Class forClass, AttendanceRecord attendanceRecord, Attendance attendance}) async {
    FirebaseDB.dbInstance.runTransaction((transaction) async {
      var attendanceRecords = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className).collection('term_attendance');
      var attendanceForDay = attendanceRecords.doc(attendanceRecord.attendanceDocumentId).collection('day_attendance');
      await attendanceForDay.doc(attendance.docID).update(attendance.toMap());

      if(attendance.present) {
        attendanceRecord.markPresent(forAttendee: attendance);
        await attendanceRecords.doc(attendanceRecord.attendanceDocumentId).update(attendanceRecord.toMap());
      }
      else {
        attendanceRecord.markAbsent(forAttendee: attendance);
        await attendanceRecords.doc(attendanceRecord.attendanceDocumentId).update(attendanceRecord.toMap());
      }
    });

  }
  
  static getAttendanceHistory({Class forClass}) {
    var attendanceRecords = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className).collection('term_attendance');
    return attendanceRecords.orderBy('record_date', descending: true).snapshots();
  }
  
  static getAttendanceForDay({Class forClass, AttendanceRecord attendanceRecord}) {
    var attendanceRecords = FirebaseDB.subjects.doc(forClass.subject).collection('classes').doc(forClass.className).collection('term_attendance');
    var attendanceForDay = attendanceRecords.doc(attendanceRecord.attendanceDocumentId).collection('day_attendance');

    return attendanceForDay.orderBy('present').snapshots();
  }

}