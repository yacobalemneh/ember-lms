class SchoolAdmin {

  String firstName;
  String lastName;

  String email;

  String image;

  String id;


  bool firstLogin;
  String password;

  String schoolName;

  String schoolId;

  DateTime accountCreated;

  String role = 'admin';


  SchoolAdmin({this.firstName, this.lastName, this.email}) {
    this.accountCreated = DateTime.now();
    this.firstLogin = true;
  }

  get fullName => firstName + ' ' + lastName;


  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'role': role,
      'image': null,
      'id': id,
      'school_name' : schoolName,
      'school_id' : schoolId,
      'account_created' : accountCreated,
      'password' : password,
      'first_login' : firstLogin,
      'full_name' : fullName,
    };
  }


}
