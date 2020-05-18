import 'package:ember/Components/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/ProfileViews/AdminView/ViewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';

class ViewStudentsForParent extends StatelessWidget {

  final User currentUser;
  final School currentSchool;

  final User toParent;

  ViewStudentsForParent({this.currentUser, this.currentSchool, this.toParent});


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Students',
        description: '${currentSchool.studentCount} Students',
        isAdmin: true,
        hasBackButton: false,
        trailing: NavigationButton(
          title: 'Done',
          onPressed: ()  {
            Navigator.pop(context, toParent);
          },
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
              autofocus: true,
            ),
            StreamBuilder(
              stream: FirebaseDB.getAllStudents(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null &&
                    snapshot.data.docs.length != 0) {
                  return ListView.builder(
                    shrinkWrap: true, itemBuilder: (context, index) {
                    var data = snapshot.data.docs[index].data();
                    DocumentReference studentReference = snapshot.data.docs[index].reference;
                    User student = User.fromMap(data);
                    student.userDocument = studentReference;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: ToggleListButton(
                        circleAvatar: ThemeCircleAvatar(
                          radius: 25,
                          userName: data['first_name'],
                          image: data['image'],
                        ),
                        title: student.fullName,
                        description: data['grade'] != null ? 'Grade: ${data['grade']}' : 'Grade Not Assigned',
                        userId: data['id'],
                        initialValue: student.parents.length > 0 && student.parents.contains(toParent.userDocument) ? true : false,
                        isToggled: (isOn) async{
                          if(isOn) {
                            await AdminOperations.associateParentAndStudent(parent: toParent, student: student);
                            toParent.children.add(studentReference);
                          }
                          else {
                            await AdminOperations.disassociateParentAndStudent(parent: toParent, student: student);
                            toParent.children.remove(studentReference);
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

