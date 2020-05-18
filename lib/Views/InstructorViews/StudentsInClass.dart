import 'package:ember/Components/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/InstructorViews/ViewStudentProfile.dart';
import 'package:ember/Views/ProfileViews/AdminView/ViewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';

_buildWidgets(Class userClass, User currentUser) {
  
  return FutureBuilder(
    future: InstructorOperations.getStudentsInClass(forClass: userClass),
    builder: (BuildContext context, snapshot) {

      print(snapshot);
      if(snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: Column(
          children: [
            SizedBox(height: getDeviceHeight(context)/2.7,),
            CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
          ],
        ));
      }
      else if (snapshot.data != null) {
        return ListView.builder(
          shrinkWrap: true, itemBuilder: (context, index) {
          return GenericNavigator(
            circleAvatar: ThemeCircleAvatar(
              radius: 25,
              userName: snapshot.data[index].data()['first_name'],
              image: snapshot.data[index].data()['image'],
            ),
            title: snapshot.data[index].data()['first_name'] + ' ' + snapshot.data[index].data()['last_name'],
            description: 'Tap to View Profile',
            trailing: snapshot.data[index].data()['id'],
            onPressed: () async {
              onLoading(context, true);
              var userToView = await FirebaseDB.getUserInfo(
                snapshot.data[index].data()['id']
                    .toString(),);
              onLoading(context, false);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>
                  ViewStudentProfile(currentUser: currentUser, userToView: User.fromMap(userToView))));
            },

          );
        }, itemCount: snapshot.data.length,
        );
      }
      else
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ThemeBanner(
            title: 'No Students In this Class',
            description: 'Wait for Admin to Add Students...',
          ),
        );
    },
  );
}

class StudentsInClass extends StatelessWidget {

  final User currentUser;
  final School currentSchool;
  final Class userClass;

  StudentsInClass({this.currentUser, this.currentSchool, this.userClass});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Students in ${userClass.className}',
        description: 'Students',
        hasBackButton: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildWidgets(userClass, currentUser)
          ],
        ),

      ),
    );
  }
}

class StudentsInClassWeb extends StatelessWidget {

  final User currentUser;
  final School currentSchool;
  final Class userClass;

  StudentsInClassWeb({this.currentUser, this.currentSchool, this.userClass});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ThemeContainer(
        padding: EdgeInsets.symmetric(horizontal: 3),
        width: kWebSecondTabWidth(context),
        child: _buildWidgets(userClass, currentUser),
      ),
    );
  }
}


