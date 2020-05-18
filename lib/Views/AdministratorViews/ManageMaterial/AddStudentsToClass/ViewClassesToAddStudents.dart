
import 'package:ember/Views/AdministratorViews/ManageMaterial/AddStudentsToClass/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/AdministratorViews/Components/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';

class ViewClassesToAddStudents extends StatelessWidget {

  final User currentUser;
  final School currentSchool;
  final String subject;

  ViewClassesToAddStudents({this.currentUser, this.currentSchool, this.subject});


  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Classes in $subject',
        hasBackButton: true,
      ),

      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseDB.getClassesInSubject(subject),
          builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());

            }
            else if(snapshot.data != null && snapshot.data.docs.length != 0) {
              return ListView.builder(
                shrinkWrap: true, itemBuilder: (context, index) {
                  var data = snapshot.data.docs[index].data();
                  DocumentReference classRef = snapshot.data.docs[index].reference;
                  Class classToAddTo = Class().fromMap(data);
                  classToAddTo.classReference = classRef;
                  int studentCount = classToAddTo.students != null ? classToAddTo.students.length : 0;
                  print(studentCount);
                return GenericNavigator(
                  title: data['class_name'],
                  trailing: '$studentCount Students',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewStudentsToAddToClass(currentUser: currentUser, currentSchool: currentSchool, toClass: classToAddTo, )));

                  },
                );
              }, itemCount: snapshot.data.docs.length,
              );
            }
            else
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ThemeBanner(
                  title: 'No Classes',
                  description: 'Add Some Classes...',
                ),
              );
          },
        ),
      ),
    );
  }
}
