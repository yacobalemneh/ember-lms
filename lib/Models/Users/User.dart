import 'package:ember/Database/all.dart';

enum UserRole {
  student,
  instructor,
  schoolAdmin,
  parent,
}

class User {

  String userId;
  String first_name;
  String last_name;
  String role;
  String image;
  String schoolName;
  String schoolId;

  String email;

  bool firstLogin;

  List<dynamic> parents;

  List<dynamic> children;

  List<dynamic> classes;

  DocumentReference userDocument;

  UserRole Role;

  String parentNames;
  getGuardians(User currentUser) async {
    for (var parent in currentUser.parents) {
      var parentInfo = await parent.get();
      parentNames = parentInfo.data()['full_name'] + ', ';
    }
  }



  User(
      {this.userId,
      this.first_name,
      this.last_name,
      this.role,
      this.image,
      this.userDocument,
      this.classes,
        this.parents,
      this.children,
      this.schoolName,
      this.schoolId,
      this.firstLogin,
      this.email}) {

    User.isLoggedIn = true;
    if(this.role == 'student')
      this.Role = UserRole.student;
    else if(this.role == 'instructor')
      this.Role = UserRole.instructor;
    else if(this.role == 'admin')
      this.Role = UserRole.schoolAdmin;
    else
      this.Role = UserRole.parent;
  }



  get fullName => first_name + ' ' + last_name;

  static bool isLoggedIn;

  static fromMap(var user) {
    return User(
      userId: user['id'].toString(),
      first_name: user['first_name'],
      last_name: user['last_name'],
      role: user['role'],
      image: user['image'],
      classes: user['classes'],
      children: user['children'],
      schoolName: user['school_name'],
      schoolId: user['school_id'],
      firstLogin: user['first_login'],
      email: user['email'],
      parents: user['parents'],
    );
  }
}
