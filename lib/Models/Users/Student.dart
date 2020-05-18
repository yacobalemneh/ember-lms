
import 'package:flutter/cupertino.dart';

import '../all.dart';

class Student {
  String firstName;
  String lastName;

  String studentId;

  String schoolName;
  String schoolId;

  DateTime birthDay;
  DateTime accountCreated;

  bool firstLogin;

  String image;
  String password;

  String grade;
  String role = 'student';

  List<String> classes = [];

  List<dynamic> parents = [];

  get fullName => firstName + ' ' + lastName;

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'id': studentId,
      'role': role,
      'dob': birthDay,
      'school_name' : schoolName,
      'school_id' : schoolId,
      'image': null,
      'grade' : grade,
      'classes' : classes,
      'account_created' : accountCreated,
      'parents' : parents,
      'first_login' : firstLogin,
      'password' : password,
      'full_name' : fullName,
    };
  }


  Student({this.firstName, this.lastName, this.birthDay, this.grade}) {
    this.accountCreated = DateTime.now();
    this.firstLogin = true;

  }
}
