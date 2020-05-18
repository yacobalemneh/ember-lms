
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/AdministratorViews/Components/all.dart';
import 'package:ember/Components/all.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ember/Database/FirebaseDB.dart';

class AddCoursesForStudent extends StatelessWidget {

  final String subject;

  final User student;

  AddCoursesForStudent({this.subject, this.student});

  Widget build(BuildContext context) {

    List<DocumentReference> classes = [];

    List<String> class_names = [];

    bool value = false;
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Assign Courses',
        isAdmin: true,
        description: 'Pick Classes For Student',
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Done',
          onPressed: () async {

            onLoading(context, true);

            var studentReference = await FirebaseDB.getUserDocumentReference(student.userId);
            await FirebaseDB.addStudentToClass([studentReference], subject, class_names);

            await FirebaseDB.assignClassForStudent(classes, student.userId);
            onLoading(context, false);

            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseDB.getClassesInSubject(subject),
          builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.data != null && snapshot.data.docs.length != 0) {
              return ListView.builder(
                shrinkWrap: true, itemBuilder: (context, index) {
                return ToggleListButton(

                  title: snapshot.data.docs[index].data()['class_name'] ,
                  description: snapshot.data.docs[index].data()['instructor_name'] != null ? snapshot.data.docs[index].data()['instructor_name'] : 'Instructor Not Assigned',
                  isToggled: (bool)  {
                    print(snapshot.data.docs[index].reference);
                    bool ? classes.add(snapshot.data.docs[index].reference):
                        classes.remove(snapshot.data.docs[index].reference);
                    bool ? class_names.add(snapshot.data.docs[index].data()['class_name']) :
                    class_names.remove(snapshot.data.docs[index].data()['class_name']);

                    print(class_names);

                    print(classes);

                  },

                );
              }, itemCount: snapshot.data.docs.length,
              );
            }
            else
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ThemeBanner(
                  title: 'No Classes for Subject',
                  description: 'Add some Classes',
                ),
              );
          },
        ),
      ),
    );
  }
}
