import 'package:ember/Components/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/ProfileViews/AdminView/ViewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';

class ViewStudentsToAddToClass extends StatelessWidget {

  final User currentUser;
  final School currentSchool;

  final Class toClass;

  ViewStudentsToAddToClass({this.currentUser, this.currentSchool, this.toClass});


  @override
  Widget build(BuildContext context) {

    // List<DocumentReference> students = [];

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Students',
        description: '${currentSchool.studentCount} Students',
        isAdmin: true,
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Done',
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ThemeTextField(
              padding: EdgeInsets.only(left: 5, right: 4, top: 5, bottom: 5),
              placeholder: 'Student name, ID...',
              leadingIcon: Icon(Icons.search),

            ),
            StreamBuilder(
              stream: FirebaseDB.getAllStudents(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Column(
                    children: [
                      SizedBox(height: getDeviceHeight(context)/2.5,),
                      CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
                    ],
                  ));
                }
                else if (snapshot.data != null &&
                    snapshot.data.docs.length != 0) {
                  return ListView.builder(
                    shrinkWrap: true, itemBuilder: (context, index) {
                      var data = snapshot.data
                          .docs[index].data();
                      User student = User.fromMap(data);
                      student.userDocument = snapshot.data
                          .docs[index].reference;
                      var studentClasses = data['classes'].toList();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: ToggleListButton(
                        circleAvatar: ThemeCircleAvatar(
                          radius: 25,
                          userName: student.fullName,
                          image: student.image,
                        ),
                        title: student.fullName,
                        description: data['grade'] != null ? 'Grade: ${data['grade']}' : 'Grade Not Assigned',
                        initialValue: studentClasses.length != 0 && studentClasses.contains(toClass.classReference) ? true : false,
                        isToggled: (isOn) async {
                          if(isOn) {
                            await AdminOperations.relateClassWithStudent(withClass: toClass, student: student);
                            toClass.students.add(student.userDocument);
                          }
                          else {
                            await AdminOperations.removeClassForStudent(withClass: toClass, student: student);
                            toClass.students.remove(student.userDocument);
                          }
                        },
                      ),
                    );
                  }, itemCount: snapshot.data.docs.length,
                  );
                }
                else
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ThemeBanner(
                      title: 'No Students',
                      description: 'Add some Students...',
                    ),
                  );
              },
            ),
          ],
        ),

      ),
    );
  }
}

