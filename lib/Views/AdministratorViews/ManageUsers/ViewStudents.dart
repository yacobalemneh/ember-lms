import 'package:ember/Components/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/ProfileViews/AdminView/ViewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';

class ViewStudents extends StatelessWidget {

  final User currentUser;
  final School currentSchool;

  ViewStudents({this.currentUser, this.currentSchool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Students',
        description: '${currentSchool.studentCount} Students',
        isAdmin: true,
        hasBackButton: true,
        trailing: NavigationButton(
          icon: Icon(
            Icons.add,
            size: 35,
            color: kThemeOrangeFinal,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddStudent(currentUser: currentUser, currentSchool: currentSchool,)));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: kIsWeb ? getDeviceWidth(context) / 3 : null,
              child: ThemeTextField(
                padding: EdgeInsets.only(left: 5, right: 4, top: 5, bottom: 5),
                placeholder: 'Student name...',
                leadingIcon: Icon(Icons.search),
                autofocus: true,
              ),
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
                        onPressed: () {

                            User student = User.fromMap(snapshot.data.docs[index].data());
                            student.userDocument = snapshot.data.docs[index].reference;

                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                ViewProfile(currentUser: currentUser, userToView: student, currentSchool: currentSchool,)));
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

