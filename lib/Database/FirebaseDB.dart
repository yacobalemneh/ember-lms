import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Helper/all.dart';
import 'package:ember/Models/Course/CourseFile.dart';
import 'package:ember/Models/Course/DiscussionPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../Models/School.dart';
import 'package:ember/Models/all.dart';

export 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseDB {
  static Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    assert(app != null);
    print('Initialized default app $app');
  }

  static String schoolName;

  static final dbInstance = FirebaseFirestore.instance;

  static final allUsers = dbInstance.collection('all_users');

  static final schools = dbInstance.collection('schools');

  static final school = schools.doc(schoolName);

  static final school_announcements = school.collection('school_announcements');

  static final messages = school.collection('messages');

  static final users = school.collection('users');

  static final subjects = school.collection('subjects');


  static getUserGrades(Class forClass, User forStudent) {
    var gradeDocuments = subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .collection('grades');
    return gradeDocuments
        .doc(forStudent.userId)
        .collection('all_grades')
        .snapshots();
  }

  static addGradedAssignmentForStudent(Class forClass, User forStudent,
      Assignment forAssignment, GradedAssignment gradedAssignment) {
    var gradeDocuments = subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .collection('grades');
    gradeDocuments
        .doc(forStudent.userId)
        .collection('all_grades')
        .add(gradedAssignment.toMap());

  }

  static gradeSubmission(Class forClass, User forStudent,
      Assignment forAssignment, GradedAssignment gradedAssignment) async {

    dbInstance.runTransaction((transaction) async {
      var submissionsDocuments = subjects
          .doc(forClass.subject)
          .collection('classes')
          .doc(forClass.className)
          .collection('submissions');
      var userSubmission = await submissionsDocuments
          .where('student_id', isEqualTo: forStudent.userId)
          .where('assignment_id', isEqualTo: forAssignment.assignmentDocId)
          .get();

      for (var document in userSubmission.docs) {
        var reference = document.reference;
        await reference.update({
          'received_grade': gradedAssignment.receivedGrade,
          'instructor_comments': gradedAssignment.instructorComments
        });
      }
      var gradeDocuments = subjects
          .doc(forClass.subject)
          .collection('classes')
          .doc(forClass.className)
          .collection('grades');
      gradeDocuments
          .doc(forStudent.userId)
          .collection('all_grades')
          .add(gradedAssignment.toMap());


    });

    // var submissionsDocuments = subjects
    //     .doc(forClass.subject)
    //     .collection('classes')
    //     .doc(forClass.className)
    //     .collection('submissions');
    // var userSubmission = await submissionsDocuments
    //     .where('student_id', isEqualTo: forStudent.userId)
    //     .where('assignment_id', isEqualTo: forAssignment.assignmentDocId)
    //     .get();
    //
    // for (var document in userSubmission.docs) {
    //   var reference = document.reference;
    //   await reference.update({
    //     'received_grade': gradedAssignment.receivedGrade,
    //     'instructor_comments': gradedAssignment.instructorComments
    //   });
    // }
    //
    // addGradedAssignmentForStudent(
    //     forClass, forStudent, forAssignment, gradedAssignment);
  }

  static getAllSubmissionsForAssignment(
      Class forClass, Assignment forAssignment) {
    var submissionsDocuments = subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .collection('submissions');
    var submissionsForAssignment = submissionsDocuments.where('assignment_id',
        isEqualTo: forAssignment.assignmentDocId);
    var submissionSnapshot = submissionsForAssignment.snapshots();
    return submissionSnapshot;
  }

  static getSubmissionsForStudent(
      Class forClass, User forUser, Assignment forAssignment) {
    var submissionsDocuments = subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .collection('submissions');
    var userSubmission = submissionsDocuments
        .where('student_id', isEqualTo: forUser.userId)
        .where('assignment_id', isEqualTo: forAssignment.assignmentDocId);

    return userSubmission.get();
  }

  static submitAssignment(Class forClass, Submission submission) {
    var assignmentRef = subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .collection('assignments');
    assignmentRef.doc(submission.assignmentID).update({
      'submitted_by': FieldValue.arrayUnion([submission.studentId])
    });
    var submissionRef = subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .collection('submissions');
    submissionRef.add(submission.toMap());
  }

  static getAssignmentsForClass(Class forClass) {
    var assignmentRef = subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .collection('assignments');

    return assignmentRef.orderBy('created_on', descending: true).snapshots();
  }

  static updateProfileImage(String userId, String imageURL) async {
    var userDocument = await users.doc(userId);
    userDocument.update({'image': imageURL});
  }

  static createChatId(String firstUser, String secondUser) {
    return isGreater(firstUser, secondUser)
        ? firstUser + secondUser
        : secondUser + firstUser;
  }

  static bool isGreater(String first, String second) {
    return first.compareTo(second) < 1;
  }

  static getMessages(String chatId) {
    var messageRef = messages.doc(chatId).collection('chats');

    return messageRef.orderBy('time', descending: true).snapshots();
  }

  static setReadForMessage(String chatId) async {
    await messages.doc(chatId).update({'read_by_reciever': true});
  }

  static getAllInInbox(String userid) {
    var chatRooms = messages.where('participants', arrayContains: userid);

    return chatRooms.snapshots();
  }

  static createMessage(
      String chatId, Message message, MessageTracker tracker) async {
    messages.doc(chatId).set(tracker.toMap());
    var messageRef = messages.doc(chatId).collection('chats');
    messageRef.add(message.toMap());
  }

  static getDiscussionPosts(String subject, String className) {
    var classRef = subjects
        .doc(subject)
        .collection('classes')
        .doc(className)
        .collection('discussions');
    return classRef.orderBy('date', descending: true).snapshots();
  }

  static addDisscussionPost(
      String subject, String className, DiscussionPost post) {
    var classRef = subjects
        .doc(subject)
        .collection('classes')
        .doc(className)
        .collection('discussions');
    classRef.doc().set(post.toMap());
  }

  static getAllVideos(String subject, String className) {
    var classRef = subjects
        .doc(subject)
        .collection('classes')
        .doc(className)
        .collection('videos');
    return classRef.snapshots();
  }

  static getAllLectureNotes(Class forClass) {
    var classRef = subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .collection('lecture_notes');
    return classRef.orderBy('date', descending: true).snapshots();
  }

  static getAllFiles(String subject, String className) {
    var classRef = subjects
        .doc(subject)
        .collection('classes')
        .doc(className)
        .collection('files');
    return classRef.orderBy('date', descending: true).snapshots();
  }

  static getUserDocument(String id) async {
    var userDocument = await users.doc(id).get();
    return userDocument;
  }

  static getUserDocumentReference(String id) async {
    var userDocument = await users.doc(id).get();
    return userDocument.reference;
  }

  static getGeneralInfo(String id) async {
    var userInfo = await allUsers.doc(id).get();
    return userInfo.data();
  }

  static getUserInfo(String id) async {
    var userInfo = await users.doc(id).get();
    return userInfo.data();
  }



  static addStudentToClass(List<DocumentReference> students, String subject,
      List<String> class_names) {
    for (var className in class_names) {
      var classRef = subjects.doc(subject).collection('classes').doc(className);
      classRef.update({'students': FieldValue.arrayUnion(students)});
    }
  }

  // static relateClassWithStudent(String studentId, List<DocumentReference> classes, ) async {
  //
  //   await dbInstance.runTransaction((transaction) async {
  //
  //     users
  //         .doc(studentId)
  //         .update({'classes': FieldValue.arrayUnion(classes)});
  //   });
  //
  // }

  static assignClassForStudent(
      List<DocumentReference> classes, String studentId) {
    users.doc(studentId).update({'classes': FieldValue.arrayUnion(classes)});
  }

  static getUserClasses(String id) async {
    var userDocument = await getUserInfo(id);
    var userClasses = await userDocument['classes'];
    var classes = [];
    for (var userClass in userClasses) classes.add(userClass);
    return classes;
  }

  // static removeClassForStudent(
  //     String userId, DocumentReference classReference) async {
  //   await dbInstance.runTransaction((transaction) async {
  //     var userDocument = users.doc(userId);
  //     userDocument.update({
  //       'classes': FieldValue.arrayRemove([classReference])
  //     });
  //     var userFile = await userDocument.get();
  //     var userReference = userFile.reference;
  //     classReference.update({
  //       'students': FieldValue.arrayRemove([userReference])
  //     });
  //   });
  // }

  static deleteUser(String userId) {
    users.doc(userId).delete();
  }

  static getClassesInSubject(String subject) {
    var classes = subjects.doc(subject).collection('classes').snapshots();
    return classes;
  }

  static getAllCourses() {
    Stream<QuerySnapshot> snapshot = subjects.snapshots();
    return snapshot;
  }
  
  static addStudentsToClass({List<DocumentReference> students, Class toClass}) async {
    await dbInstance.runTransaction((transaction) async {
      
      await subjects.doc(toClass.subject).collection('classes').doc(toClass.className).update({'students': FieldValue.arrayUnion(students)});

      for (var student in students)
        student.update({'classes' : FieldValue.arrayUnion([toClass.classReference])});

    });
  }

  static addClass(Class forClass) async {
    subjects
        .doc(forClass.subject)
        .collection('classes')
        .doc(forClass.className)
        .set(forClass.toMap());
    // var classDocument = await subjects.doc(forClass.subject).collection('classes').doc(forClass.className).get();
    // DocumentReference classReference = classDocument.reference;
    // subjects.doc(forClass.subject).collection('classes').doc(forClass.className).update({''});
    
    
  }

  static addSubject(Subject subject) {
    subjects.doc(subject.subjectName).set(subject.toMap());
  }

  static searchAllUsers(String name) {
    var searchedUsers = users.where('first_name', isEqualTo: name);

    if (searchedUsers.snapshots() != null) {
      return searchedUsers.snapshots();
    } else if (searchedUsers.snapshots() == null) {
      searchedUsers = users.where('last_name', isEqualTo: name);
      return searchedUsers.snapshots();
    } else {
      searchedUsers = users.where('id', isLessThanOrEqualTo: name);
      return searchedUsers.snapshots();
    }
  }

  static get getAllUsers {
    Stream<QuerySnapshot> snapshot = users.snapshots();
    return snapshot;
  }

  static get userCount {
    Stream<QuerySnapshot> snapshot = users.snapshots();
    return snapshot.length;
  }

  static userExistsInEmber(String userId) async {
    print(userId);
    var usersDoc = await allUsers.doc(userId).get();
    print(usersDoc.data());


    return usersDoc.exists;
  }

  static userExistsInSchool(String userId) async {
    var userDocInSchool = await users.doc(userId).get();

    return userDocInSchool.exists;
  }

  static getAllInstructors() {
    Stream<QuerySnapshot> snapshot =
        users.where('role', isEqualTo: 'instructor').snapshots();
    return snapshot;
  }

  static getAllAdmins() {
    Stream<QuerySnapshot> snapshot =
        users.where('role', isEqualTo: 'admin').snapshots();
    return snapshot;
  }

  static getAllStudents() {
    Stream<QuerySnapshot> snapshot =
        users.where('role', isEqualTo: 'student').snapshots();
    return snapshot;
  }

  static getAllParents() {
    Stream<QuerySnapshot> snapshot =
        users.where('role', isEqualTo: 'parent').snapshots();

    return snapshot;
  }

  static createSchoolAnnouncement(School forSchool, Announcement announcement) {
    school_announcements.add(announcement.toMap());
  }

  static getSchoolAnnouncements(School forSchool) {
    var announcementRef = school_announcements;
    return school_announcements.orderBy('date', descending: true).snapshots();
  }

  static deleteSchoolAnnouncement(School forSchool, String announcementId) {
    school_announcements.doc(announcementId).delete();
  }

  static getSchool(String schoolID) async {
    var school = await schools.doc(schoolID).get();
    return school.data();
  }
}
