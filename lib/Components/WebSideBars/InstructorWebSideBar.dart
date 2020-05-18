import 'package:ember/IconHandler.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/constants.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ember/Models/all.dart';

class InstructorWebSideBar extends StatefulWidget {
  final User currentUser;
  final School school;

  final Function onDashboard;
  final Function onStudents;
  final Function onMessages;
  final Function onProfile;

  InstructorWebSideBar({
    this.currentUser,
    this.school,
    this.onDashboard,
    this.onStudents,
    this.onProfile,
    this.onMessages,
  });

  @override
  _InstructorWebSideBarState createState() => _InstructorWebSideBarState();
}

class _InstructorWebSideBarState extends State<InstructorWebSideBar> {
  bool dashboardPressed = true;
  bool studentsPressed = false;
  bool messagePressed = false;
  bool profilePressed = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(11)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            // offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: 75,
      child: Column(children: [
        Container(
          width: 80,
          child: Image.asset('assets/appIcon.png'),
        ),
        SizedBox(
          height: 42,
        ),
        ThemeCircleAvatar(
          userName: widget.currentUser.fullName,
          image: widget.currentUser.image,
          radius: 20,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          widget.currentUser.fullName,
          textAlign: TextAlign.center,
          style: kThemeTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          widget.school.schoolName,
          textAlign: TextAlign.center,
          style: kThemeTextStyle.copyWith(
              fontWeight: FontWeight.w300, fontSize: 11, color: kThemeGreen),
        ),
        SizedBox(
          height: 49,
        ),
        dashboardPressed
            ? IconButton(
          icon: IconHandler.dashboardActive,
          onPressed: null,
        )
            : IconButton(
          icon: IconHandler.dashboard,
          onPressed: () {
            setState(() {
              dashboardPressed = true;
              studentsPressed = false;
              messagePressed = false;
              profilePressed = false;
              widget.onDashboard();
            });
          },
        ),
        SizedBox(
          height: 17,
        ),
        studentsPressed
            ? IconButton(
          icon: IconHandler.viewStudentsActive,
          onPressed: null,
        )
            : IconButton(
          icon: IconHandler.viewStudents,
          onPressed: () {
            setState(() {
              studentsPressed = true;
              messagePressed = false;
              profilePressed = false;
              dashboardPressed = false;
              widget.onStudents();
            });
          },
        ),
        SizedBox(
          height: 17,
        ),
        messagePressed
            ? IconButton(
          icon: IconHandler.messageActive,
          onPressed: null,
        )
            : IconButton(
          icon: IconHandler.message,
          onPressed: () {
            setState(() {
              messagePressed = true;
              studentsPressed = false;
              profilePressed = false;
              dashboardPressed = false;
              widget.onMessages();
            });
          },
        ),
        SizedBox(
          height: 17,
        ),
        profilePressed
            ? IconButton(
          icon: IconHandler.profileActive,
          onPressed: null,
        )
            : IconButton(
          icon: IconHandler.profile,
          onPressed: () {
            setState(() {
              profilePressed = true;
              studentsPressed = false;
              messagePressed = false;
              dashboardPressed = false;
              widget.onProfile();
            });
          },
        ),
      ]),
    );
  }
}
