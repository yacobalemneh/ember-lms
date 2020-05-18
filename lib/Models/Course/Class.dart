import 'package:ember/Database/all.dart';


class Class {

  String className;
  String subject;
  String instructorName;
  String instructorId;

  String aboutClass;

  List<dynamic> students = [];

  DocumentReference classReference;

  DocumentReference instructor;

  Class({this.className, this.instructorName, this.instructorId, this.subject, this.instructor, this.students, this.aboutClass});

  fromMap(var parsedJson) {
    return Class(
      className: parsedJson['class_name'],
      subject: parsedJson['subject'],
      instructorName: parsedJson['instructor_name'],
      instructorId: parsedJson['instructor_id'],
      students: parsedJson['students'],
      instructor: parsedJson['instructor'],
      aboutClass : parsedJson['about_class'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'class_name' : className,
      'subject' : subject,
      'instructor_name' : instructorName,
      'instructor_id' : instructorId,
      'students' : students,
      'instructor' : instructor,
      'about_class' : aboutClass,
    };
  }

  static getCourses(String id) async {
    var userCourses = await FirebaseDB.getUserClasses(id);

    var courses = [];

    List<Class> fromMap = [];

    for(var course in userCourses) {
      var courseData = await course.get();
      fromMap.add(Class(
        className: courseData.data()['class_name'],
        instructorName: courseData.data()['instructor_name'] == null ? 'Not Assigned' : courseData.data()['instructor_name'],
        instructorId: courseData.data()['instructor_id'],
        subject: courseData.data()['subject'],
        instructor : courseData.data()['instructor'],
        aboutClass: courseData.data()['about_class'],
      ));
      courses.add(courseData);


    }

    return fromMap;

  }

}