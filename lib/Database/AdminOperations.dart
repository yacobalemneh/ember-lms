
import 'package:ember/Database/FirebaseDB.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Helper/all.dart';


class AdminOperations extends FirebaseDB {


  static addStudent({Student student, School forSchool}) async {
    await FirebaseDB.dbInstance.runTransaction((transaction) async {
      student.studentId = await UserNameGenerator().generateUsername(student.firstName, student.lastName, forSchool.schoolName);
      student.schoolName = forSchool.schoolName;
      student.schoolId = forSchool.schoolId;
      student.password = PasswordGenerator().generatePassword();
      FirebaseDB.users.doc(student.studentId.toString()).set(student.toMap());
      FirebaseDB.allUsers.doc(student.studentId).set(student.toMap());
    });
  }

  static addParent({Parent parent, School forSchool}) async {
    await FirebaseDB.dbInstance.runTransaction((transaction) async {
      parent.id = await UserNameGenerator().generateUsername(parent.firstName, parent.lastName, forSchool.schoolName);
      parent.schoolName = forSchool.schoolName;
      parent.schoolId = forSchool.schoolId;
      parent.password = PasswordGenerator().generatePassword();
      FirebaseDB.users.doc(parent.id).set(parent.toMap());
      FirebaseDB.allUsers.doc(parent.id).set(parent.toMap());
    });

  }


  static addInstructor({Instructor instructor, School forSchool}) async {

    await FirebaseDB.dbInstance.runTransaction((transaction) async {
      instructor.id = await UserNameGenerator().generateUsername(instructor.firstName, instructor.lastName, forSchool.schoolName);
      instructor.schoolName = forSchool.schoolName;
      instructor.schoolId =  forSchool.schoolId;
      instructor.password = PasswordGenerator().generatePassword();
      FirebaseDB.users.doc(instructor.id).set(instructor.toMap());
      FirebaseDB.allUsers.doc(instructor.id).set(instructor.toMap());
    });

  }

  static addAdmin({SchoolAdmin schoolAdmin, School forSchool}) async {
    await FirebaseDB.dbInstance.runTransaction((transaction) async {
      schoolAdmin.id = await UserNameGenerator().generateUsername(schoolAdmin.firstName, schoolAdmin.lastName, forSchool.schoolName);
      schoolAdmin.schoolName = forSchool.schoolName;
      schoolAdmin.schoolId = forSchool.schoolId;
      schoolAdmin.password = PasswordGenerator().generatePassword();
      FirebaseDB.users.doc(schoolAdmin.id).set(schoolAdmin.toMap());
      FirebaseDB.allUsers.doc(schoolAdmin.id).set(schoolAdmin.toMap());
    });
  }

  static changeUserEmail({User user}) async {
    await FirebaseDB.dbInstance.runTransaction((transaction) async {
      await FirebaseDB.users.doc(user.userId).update({'email' : user.email});
      await FirebaseDB.allUsers.doc(user.userId).update({'email' : user.email});

    });
  }
  
  static associateParentAndStudent({User parent, User student}) async {
    await FirebaseDB.dbInstance.runTransaction((transaction) async {
      await FirebaseDB.users.doc(parent.userId).update({'children' : FieldValue.arrayUnion([student.userDocument])});
      await FirebaseDB.users.doc(student.userId).update({'parents' : FieldValue.arrayUnion([parent.userDocument])});
    });
  }

  static disassociateParentAndStudent({User parent, User student}) async {
    await FirebaseDB.dbInstance.runTransaction((transaction) async {
      await FirebaseDB.users.doc(parent.userId).update({'children' : FieldValue.arrayRemove([student.userDocument])});
      await FirebaseDB.users.doc(student.userId).update({'parents' : FieldValue.arrayRemove([parent.userDocument])});
    });
  }

  static relateClassWithInstructor({Class withClass, User instructor}) async {
    FirebaseDB.dbInstance.runTransaction((transaction) async {
      await FirebaseDB.dbInstance.runTransaction((transaction) async {
        FirebaseDB.subjects
            .doc(withClass.subject)
            .collection('classes')
            .doc(withClass.className)
            .update({
          'instructor_name': instructor.fullName,
          'instructor_id': instructor.userId,
          'instructor': instructor.userDocument,
        });
        FirebaseDB.users.doc(instructor.userId).update({
          'classes': FieldValue.arrayUnion([withClass.classReference])
        });
      });
    });
  }

  static relateClassWithStudent({Class withClass, User student}) async {
    FirebaseDB.dbInstance.runTransaction((transaction) async {
      await FirebaseDB.dbInstance.runTransaction((transaction) async {

        FirebaseDB.subjects.doc(withClass.subject).collection('classes').doc(withClass.className).update({
          'students' : FieldValue.arrayUnion([student.userDocument])
        });
        FirebaseDB.users.doc(student.userId).update({
        'classes' : FieldValue.arrayUnion([withClass.classReference])
        });
      });
    });
  }

  static removeClassForStudent({Class withClass, User student}) async {
    FirebaseDB.dbInstance.runTransaction((transaction) async {
      await FirebaseDB.dbInstance.runTransaction((transaction) async {
        FirebaseDB.subjects.doc(withClass.subject).collection('classes').doc(withClass.className).update({
          'students' : FieldValue.arrayRemove([student.userDocument])
        });
        FirebaseDB.users.doc(student.userId).update({
          'classes' : FieldValue.arrayRemove([withClass.classReference])
        });
      });
    });
  }


  static removeClassForInstructor({User instructor, Class fromClass}) {
    FirebaseDB.users.doc(instructor.userId).update({
      'classes': FieldValue.arrayRemove([fromClass.classReference])
    });
  }
  
  


}