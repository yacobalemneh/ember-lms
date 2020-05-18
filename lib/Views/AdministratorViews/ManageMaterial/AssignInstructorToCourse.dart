import 'package:ember/Database/AdminOperations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/AdministratorViews/Components/all.dart';
import 'package:ember/Components/all.dart';

import 'package:ember/Database/FirebaseDB.dart';

class AssignInstructorToCourse extends StatelessWidget {

  final Class toClass;

  AssignInstructorToCourse({this.toClass});

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Assign Courses',
        isAdmin: true,
        description: 'Please only Pick one',
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Done',
          onPressed: ()  {
            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseDB.getAllInstructors() ,
            builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.data != null && snapshot.data.docs.length != 0) {
                return ListView.builder(
                  shrinkWrap: true, itemBuilder: (context, index) {
                    var instructorClasses = snapshot.data.docs[index].data()['classes'].toList();
                    User instructor = User.fromMap(snapshot.data.docs[index].data());
                    instructor.userDocument = snapshot.data.docs[index].reference;
                  return ToggleListButton(
                      circleAvatar: ThemeCircleAvatar(
                        radius: 25,
                        userName: snapshot.data
                            .docs[index].data()['first_name'],
                        image: snapshot.data.docs[index].data()['image'],
                      ),
                      title: snapshot.data.docs[index].data()['first_name'] +
                          ' ' + snapshot.data.docs[index].data()['last_name'],
                      description: snapshot.data.docs[index].data()['id'],
                    initialValue: instructorClasses.length != 0 && instructorClasses.contains(toClass.classReference) ? true : false,
                    isToggled: (isOn)  async {

                        print(instructorClasses);
                        print(instructor.fullName);
                        print(toClass.classReference);

                        if(isOn) {
                          await AdminOperations.relateClassWithInstructor(
                             withClass: toClass,
                            instructor: instructor
                          );

                        }
                        else {
                          await AdminOperations.removeClassForInstructor(
                            instructor: instructor,
                            fromClass: toClass,
                          );
                        }

                    },

                  );
                }, itemCount: snapshot.data.docs.length,
                );
              }
              else
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ThemeBanner(
                    title: 'No Instructors',
                    description: 'Add some Instructors',
                  ),
                );
            },
          ),
        ),
    );
  }
}
