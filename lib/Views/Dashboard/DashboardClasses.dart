import 'package:ember/IconHandler.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/constants.dart';
import 'package:ember/Views/StudentClassView/all.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:ember/Database/all.dart';

class DashboardClasses extends StatelessWidget {

  final User currentUser;
  final School currentSchool;
  DashboardClasses({this.currentUser, this.currentSchool});

  @override
  Widget build(BuildContext context) {

    print(currentUser.role);
    print(currentUser.classes);


    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${currentUser.first_name}!',
                    style: TextStyle(fontSize: 24, color: Color(0xFF3E4554)),
                  ),
                  Text(
                    currentUser.role == 'student' ? 'Pick a subject you\'d like to cover.' : 'Pick a subject you\'d like to teach.',
                    style: TextStyle(fontSize: 12, color: Color(0xFFABB2C1)),
                  ),
                ],
              ),
            ),
            Container(
              width: kIsWeb ? 1100 : null,
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFF8F8F8),
              child: FutureBuilder(
                future: Class.getCourses(currentUser.userId),
                builder: (context, userClasses) {
                  if(userClasses.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        SizedBox(
                          height: getDeviceHeight(context)/3,
                        ),
                        Center(child: CircularProgressIndicator(),),
                      ],
                    );
                  }
                  else if(userClasses.data == null || userClasses.data.length == 0 ) {
                    return ThemeBanner(
                      title: "No Classes Assigned",
                      description: 'Contact your School Administrator',

                    );
                  }
                  else
                    return GridView.builder(
                      shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: kIsWeb ? 5 : 2),
                        itemBuilder:  (BuildContext context, int index) {
                          return ClassCard(
                            title: userClasses.data[index].className,
                            instructorName: userClasses.data[index].instructorName,
                            averageGrade: currentUser.role == 'instructor' ? 'Class Average: 87.3%' : 'Average: 92.5%',
                            onCardPressed: () {
                              print(userClasses.data[index].instructor);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClassPage(
                                      userClass: userClasses.data[index],
                                        currentUser: currentUser,
                                        currentSchool: currentSchool,
                                      )));
                            },
                          );
                        }, itemCount: userClasses.data.length,


                    );
                },
              ),

            ),
          ],
        ),
      ),
    );
  }
}
