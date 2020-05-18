import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';

class RecordAttendance extends StatelessWidget {
  final User currentUser;
  final School currentSchool;
  final Class userClass;

  RecordAttendance({this.currentUser, this.currentSchool, this.userClass});
  List<Attendance> studentAttendance = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Attendance for ${userClass.className}',
        description: '${DateHandler.standardDate(DateTime.now())}',
        isAdmin: true,
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Done',
          onPressed: () async {
            onLoading(context, true);
            await InstructorOperations.recordAttendance(forClass: userClass, studentAttendees: studentAttendance);
            onLoading(context, false);
            Navigator.pop(context);

          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: InstructorOperations.getStudentsInClass(forClass: userClass),
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
                } else if (snapshot.data != null) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      User student = User.fromMap(snapshot.data[index].data());
                      student.userDocument = snapshot.data[index].reference;

                      return ToggleListButton(
                        circleAvatar: ThemeCircleAvatar(
                          userName: student.fullName,
                          radius: 25,
                          image: student.image,
                        ),
                        title: student.fullName,
                        userId: student.userId,
                        description: DateHandler.standardDate(DateTime.now()),
                        isToggled: (isOn) {
                          if (isOn) {
                            Attendance record = Attendance(
                              studentName: student.fullName,
                              studentId: student.userId,
                              studentDocument: student.userDocument,
                              present: true,
                            );
                            studentAttendance.add(record);
                          } else {
                            for (var attendee in studentAttendance) {
                              if (attendee.studentId == student.userId)
                                attendee.present = false;
                            }
                          }
                        },
                      );
                    },
                    itemCount: snapshot.data.length,
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
