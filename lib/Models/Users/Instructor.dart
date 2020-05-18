import 'package:ember/Models/all.dart';

class Instructor {
  String firstName;
  String lastName;

  String email;

  String image;

  String id;

  String schoolId;

  String schoolName;

  DateTime accountCreated;

  bool firstLogin = false;

  String password;

  String role = 'instructor';

  List<String> classes = [];

  get fullName => firstName + ' ' + lastName;


  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'role': role,
      'image': null,
      'id': id,
      'classes': classes,
      'school_id' : schoolId,
      'school_name' : schoolName,
      'account_created' : accountCreated,
      'first_login' : firstLogin,
      'password' : password,
      'full_name' : fullName,
    };
  }

  Instructor({this.firstName, this.lastName, this.email}) {
    this.accountCreated = DateTime.now();
    this.firstLogin = true;
  }

}
