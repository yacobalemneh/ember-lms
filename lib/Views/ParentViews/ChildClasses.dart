import 'package:ember/Components/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/InstructorViews/ViewStudentProfile.dart';
import 'package:ember/Views/ProfileViews/AdminView/ViewProfile.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';

class ChildClasses extends StatelessWidget {

  final User currentUser;
  final User child;
  final School currentSchool;

  ChildClasses({this.currentUser, this.currentSchool,  this.child});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: child.fullName,
        description: 'Normal Standing',
        hasBackButton: true,
        isAdmin: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: Class.getCourses(child.userId),
            builder: (context, userClasses) {
              if(userClasses.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              else if(userClasses.data == null || userClasses.data.length == 0 ) {
                return ThemeBanner(
                  title: "No Classes Assigned For Child",
                  description: 'Contact your School Administrator',

                );
              }
              else
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kIsWeb ? 5 : 2),
                itemBuilder:  (BuildContext context, int index) {
                  return ClassCard(
                    title: userClasses.data[index].className,
                    instructorName: userClasses.data[index].instructorName,
                    averageGrade: currentUser.role == 'instructor' ? 'Class Average: 87.3%' : 'Average: 92.5%',
                    onCardPressed: () {
                      print(child.userId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassPage(
                                userClass: userClasses.data[index],
                                currentUser: currentUser,
                                currentSchool: currentSchool,
                                child: child,
                              )));
                    },
                  );
                }, itemCount: userClasses.data.length,


              );
            },
          ),
        ),
      )
    );
  }
}

