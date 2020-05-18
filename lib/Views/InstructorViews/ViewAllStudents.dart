import 'package:ember/Components/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/InstructorViews/ViewStudentProfile.dart';
import 'package:ember/Views/ProfileViews/AdminView/ViewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';

class ViewAllStudents extends StatelessWidget {

  final User currentUser;
  final School currentSchool;

  ViewAllStudents({this.currentUser, this.currentSchool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Students',
        description: '${currentSchool.studentCount} Students',
        hasBackButton: false,
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
                    return GenericNavigator(
                        circleAvatar: ThemeCircleAvatar(
                          radius: 30,
                          userName: snapshot.data
                              .docs[index].data()['first_name'],
                          image: snapshot.data
                              .docs[index].data()['image']
                        ),
                        title: snapshot.data.docs[index].data()['first_name'] +
                            ' ' + snapshot.data.docs[index].data()['last_name'],
                        description: snapshot.data.docs[index].data()['grade'] !=
                            null ? 'Grade: ${snapshot.data
                            .docs[index].data()['grade']}' : 'Grade Not Assigned',
                        trailing: snapshot.data.docs[index].data()['id']
                            .toString(),
                        onPressed: () async {
                          try {
                            onLoading(context, true);
                            var userToView = await FirebaseDB.getUserInfo(
                              snapshot.data.docs[index].data()['id']
                                  .toString(),);

                            onLoading(context, false);
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                ViewStudentProfile(currentUser: currentUser, userToView: User.fromMap(userToView))));
                          }
                          catch (error) {
                            print(error);
                          }
                        }
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

