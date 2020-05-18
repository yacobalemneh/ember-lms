import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Helper/all.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/StudentClassView/Components/all.dart';

Widget _buildWidgets(User currentUser, Class userClass) {
  return ListView(
    shrinkWrap: true,
    children: [
      ThemeBanner(
        title: 'Average Grade',
        trailing: '97.5%',
      ),

      ThemeBanner(
        title: 'Ranking',
        description: 'Better than 97% of students in this class',
        trailing: 'Top: 3%',
      ),

      StreamBuilder (
          stream: FirebaseDB.getUserGrades(userClass, currentUser),
          builder: (context, snapshots) {
            if(snapshots.connectionState == ConnectionState.waiting) {
              return Center(child: Column(
                children: [
                  SizedBox(height: getDeviceHeight(context)/4,),
                  CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
                ],
              ));
            }
            else if (!snapshots.hasData || snapshots.data == null || snapshots.data.docs.length == 0) {
              return ThemeBanner(title: 'No Grades Posted Yet.',);
            }
            return ListView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              itemBuilder: (context, index) {
                var data = snapshots.data.docs[index].data();
                print(data);

                return GradeListView(
                  assignmentGrade: data['possible_grade'],
                  receivedGrade: data['received_grade'],
                  assignmentName: data['assignment_name'],
                  dueDate: DateHandler.standardDate(data['due'].toDate()),
                );
              },
              itemCount: snapshots.data.docs.length,
            );
          }
      ),
    ],
  );
}

class Grades extends StatelessWidget {

  final User currentUser;
  final Class userClass;
  
  Grades({this.currentUser, this.userClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Grades' ,
        description: userClass.className,
        hasBackButton: true,
      ),

      body: SafeArea(
        child: _buildWidgets(currentUser, userClass)
      ),
    );
  }
}

class GradesWeb extends StatelessWidget {

  final User currentUser;
  final Class userClass;

  GradesWeb({this.userClass, this.currentUser});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ThemeContainer(
        width: kWebSecondTabWidth(context),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 11, right: 9, top: 7),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Grades', style: kThemeTextStyle,),
                  NavigationButton(
                    title: ' ',//'Add Lecture Note',
                    onPressed: () {
                      print('Instructor Add Lecture');
                    },
                  ),

                ],
              ),
            ),

            _buildWidgets(currentUser, userClass)

          ],
        ),
      ),
    );
  }
}

