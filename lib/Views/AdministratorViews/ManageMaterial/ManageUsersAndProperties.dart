

import 'package:ember/Database/all.dart';
import 'package:ember/IconHandler.dart';
import 'package:ember/Views/AdministratorViews/ManageMaterial/AddStudentsToClass/ViewSubjectToAddStudents.dart';

import 'package:ember/Views/AdministratorViews/ManageMaterial/ViewSubjects.dart';
import 'package:ember/Views/AdministratorViews/ManageUsers/ViewAdmins.dart';
import 'package:ember/Views/AdministratorViews/ManageUsers/ViewStudents.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';


class ManageUsersAndProperties extends StatelessWidget {


  final User currentUser;
  final School currentSchool;

  ManageUsersAndProperties({this.currentUser, this.currentSchool});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Dashboard' ,
        description: '${FirebaseDB.schoolName}',
        hasBackButton: false,
        isAdmin: true,
      ),

      body: SafeArea(
          child: ListView(
            children: [
              ListViewItemButton(
                buttonTitle: 'Subjects',
                iconImage: IconHandler.subjects,
                trailing: '${currentSchool.subjectCount} Subjects',
                trailingFontSize: 13,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSubjects(forStudent: false,)));

                },
              ),
              ListViewItemButton(
                buttonTitle: 'Students',
                iconImage: IconHandler.students,
                trailing: '${currentSchool.studentCount} Students',
                trailingFontSize: 13,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewStudents(currentUser: currentUser, currentSchool: currentSchool,)));

                },
              ),
              ListViewItemButton(
                buttonTitle: 'Teachers',
                iconImage: IconHandler.teachers,
                trailing: '${currentSchool.instructorCount} Teachers',
                trailingFontSize: 13,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTeachers(currentUser: currentUser, currentSchool: currentSchool,)));

                },
              ),
              ListViewItemButton(
                buttonTitle: 'Parents',
                iconImage: IconHandler.parents,
                trailing: '${currentSchool.parentCount} Parents',
                trailingFontSize: 13,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewParents(currentUser: currentUser, currentSchool: currentSchool,)));

                },
              ),

              ListViewItemButton(
                buttonTitle: 'School Admins',
                iconImage: IconHandler.schoolAdmin,
                trailing: '${currentSchool.adminCount} Admins',
                trailingFontSize: 13,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAdmins(currentUser: currentUser, currentSchool: currentSchool,)));

                },
              ),

              ListViewItemButton(
                buttonTitle: 'Add Students to Class',
                iconImage: IconHandler.assignToClass,
                trailing: 'Classes',
                trailingFontSize: 13,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSubjectsToAddStudents(currentUser: currentUser, currentSchool: currentSchool,)));

                },
              ),

            ],

          )
      ),
    );
  }
}
