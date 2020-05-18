import '../all.dart';

class Parent {

  String firstName;
  String lastName;

  String id;

  String email;

  String schoolName;

  String schoolId;

  String image;

  String password;

  DateTime accountCreated;

  bool firstLogin;

  String role = 'parent';

  List<dynamic> children = [];

  get fullName => firstName + ' ' + lastName;


  Parent({this.firstName, this.lastName, this.email}) {
    this.accountCreated = DateTime.now();
    this.firstLogin = true;

  }


  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'role': role,
      'image': null,
      'id': id,
      'children' : children,
      'school_id' : schoolId,
      'school_name' : schoolName,
      'account_created' : accountCreated,
      'first_login' : firstLogin,
      'password' : password,
      'full_name' : fullName,

    };
  }


}