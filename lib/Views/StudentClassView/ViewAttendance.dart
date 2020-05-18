import 'package:ember/Helper/all.dart';
import 'package:ember/IconHandler.dart';
import 'package:ember/Views/InstructorViews/all.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';


_buildWidget(User currentUser, Class userClass, School currentSchool, User child) {
  return StreamBuilder(
    stream: InstructorOperations.getAttendanceHistory(forClass: userClass),
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
            child: Column(
              children: [
                SizedBox(
                  height: getDeviceHeight(context) / 2.7,
                ),
                CircularProgressIndicator(
                  backgroundColor: kThemeOrangeFinal,
                ),
              ],
            ));
      } else if (snapshot.data != null && snapshot.data.docs.length > 0 && snapshot.hasData && snapshot.data.docs != null) {
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            AttendanceRecord attendanceRecord = AttendanceRecord.fromJson(snapshot.data.docs[index].data());
            attendanceRecord.attendanceDocumentId = snapshot.data.docs[index].id;
            return
              currentUser.Role == UserRole.instructor ?
              GenericNavigator(
                circleAvatar: IconHandler.attendance,
                title: DateHandler.standardDate(attendanceRecord.recordDate),
                description: attendanceRecord.getPercentString(attendanceRecord.percentPresent) + ' of Students Present.',
                trailing: 'Edit',
                trailingColor: attendanceRecord.presentList.contains(currentUser.userId) ? kThemeGreen : Colors.red,
                showIcon: currentUser.Role == UserRole.instructor ? true : false,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditAttendance(
                            userClass: userClass,
                            currentUser: currentUser,
                            currentSchool: currentSchool,
                            attendanceRecord: attendanceRecord,
                          )));

                },

              ) : currentUser.Role == UserRole.student ?
              GenericNavigator(
                circleAvatar: IconHandler.attendance,
                title: DateHandler.standardDate(attendanceRecord.recordDate),
                description: attendanceRecord.getPercentString(attendanceRecord.percentPresent) + ' of Students Present.',
                trailing: attendanceRecord.presentList.contains(currentUser.userId) ? 'Present' : 'Absent',
                trailingColor: attendanceRecord.presentList.contains(currentUser.userId) ? kThemeGreen : Colors.red,
                showIcon: currentUser.Role == UserRole.instructor ? true : false,
              ) :
              GenericNavigator(
                circleAvatar: IconHandler.attendance,
                title: DateHandler.standardDate(attendanceRecord.recordDate),
                description: attendanceRecord.getPercentString(attendanceRecord.percentPresent) + ' of Students Present.',
                trailing: attendanceRecord.presentList.contains(child.userId) ? 'Present' : 'Absent',
                trailingColor: attendanceRecord.presentList.contains(child.userId) ? kThemeGreen : Colors.red,
                showIcon: currentUser.Role == UserRole.instructor ? true : false,
              );


          },
          itemCount: snapshot.data.docs.length,
        );
      } else
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ThemeBanner(
            title: 'No Attendance Record Yet',
            description: currentUser.Role == UserRole.instructor ? 'Record Attendance for today...' : 'Wait for Instructor to mark Attendance...',
          ),
        );
    },
  );
}

class ViewAttendance extends StatelessWidget {
  final User currentUser;
  final School currentSchool;
  final Class userClass;

  final User child;

  ViewAttendance({this.currentUser, this.userClass, this.currentSchool, this.child});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Attendance History',
        description: '${userClass.className}',
        hasBackButton: true,
        trailing: currentUser.Role == UserRole.instructor ? NavigationButton(
          icon: IconHandler.recordAttendance,
          onPressed: ()  {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecordAttendance(
                      userClass: userClass,
                      currentUser: currentUser,
                    )));

          },
        ) : SizedBox(),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildWidget(currentUser, userClass, currentSchool, child)
          ],
        ),
      ),
    );
  }
}


class ViewAttendanceWeb extends StatelessWidget {

  final User currentUser;
  final School currentSchool;
  final Class userClass;

  final User child;

  ViewAttendanceWeb({this.currentUser, this.userClass, this.currentSchool, this.child});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ThemeContainer(
        width: kWebSecondTabWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 11, right: 9, top: 17),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Attendance History', style: kThemeTextStyle,),
                  currentUser.Role == UserRole.instructor ?
                  NavigationButton(
                    title: 'Record Attendance',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordAttendance(
                                currentUser: currentUser,
                                userClass: userClass,
                                currentSchool: currentSchool,
                              )));

                    },
                  ) : SizedBox(),
                ],
              ),
            ),

            ListView(
              shrinkWrap: true,
              children: [
                _buildWidget(currentUser, userClass, currentSchool, child)
              ],
            ),

          ],
        ),
      ),
    );
  }
}

