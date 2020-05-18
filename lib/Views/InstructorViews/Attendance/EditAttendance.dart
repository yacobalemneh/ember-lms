import 'package:ember/Helper/all.dart';
import 'package:ember/Models/Course/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';

class EditAttendance extends StatelessWidget {
  final User currentUser;
  final School currentSchool;
  final Class userClass;
  final AttendanceRecord attendanceRecord;

  EditAttendance({this.currentUser, this.currentSchool, this.userClass, this.attendanceRecord});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Edit Attendance',
        description: '${DateHandler.standardDate(attendanceRecord.recordDate)}',
        isAdmin: true,
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Update',
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: InstructorOperations.getAttendanceForDay(forClass: userClass, attendanceRecord: attendanceRecord),
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
                      Attendance attendanceForDay = Attendance.fromSnapshot(snapshot.data.docs[index]);
                      return ToggleListButton(
                        circleAvatar: ThemeCircleAvatar(
                          userName: attendanceForDay.studentName,
                        ),
                        title: attendanceForDay.studentName,
                        description: DateHandler.elaborateDate(attendanceForDay.date),
                        userId: attendanceForDay.studentId,
                        initialValue: attendanceForDay.present,
                        isToggled: (isOn) async {
                          if(isOn) {
                            attendanceForDay.present = isOn;
                            await InstructorOperations
                                .updateAttendanceForStudent(
                              forClass: userClass,
                              attendanceRecord: attendanceRecord,
                              attendance: attendanceForDay,
                            );
                          }
                          else {
                            attendanceForDay.present = isOn;
                            await InstructorOperations
                                .updateAttendanceForStudent(
                              forClass: userClass,
                              attendanceRecord: attendanceRecord,
                              attendance: attendanceForDay,
                            );
                          }
                        },

                      );

                    },
                    itemCount: snapshot.data.docs.length,
                  );
                } else
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ThemeBanner(
                      title: 'No Students In this Class',
                      description: 'Wait for Admin to Add Students...',
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
