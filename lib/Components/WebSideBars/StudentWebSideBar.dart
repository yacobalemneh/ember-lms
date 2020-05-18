import 'package:ember/IconHandler.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/constants.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ember/Models/all.dart';

class StudentWebSideBar extends StatefulWidget {
  // final String username;
  // final String school;
  // final String userImage;
  final User currentUser;
  final School school;

  final Function onDashboard;
  final Function onTodo;
  final Function onMessages;
  final Function onProfile;

  StudentWebSideBar({
    this.currentUser,
    this.school,
    this.onDashboard,
    this.onTodo,
    this.onProfile,
    this.onMessages,
  });

  @override
  _StudentWebSideBarState createState() => _StudentWebSideBarState();
}

class _StudentWebSideBarState extends State<StudentWebSideBar> {
  bool dashboardPressed = true;
  bool todoPressed = false;
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
          radius: 20,
          image: widget.currentUser.image,
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 40,
          child: AutoSizeText(
            widget.currentUser.fullName,
            wrapWords: false,
            minFontSize: 0,
            maxFontSize: 11,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: kThemeTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
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
                    todoPressed = false;
                    messagePressed = false;
                    profilePressed = false;
                    widget.onDashboard();
                  });
                },
              ),
        SizedBox(
          height: 17,
        ),
        todoPressed
            ? IconButton(
                icon: IconHandler.todoActive,
                onPressed: null,
              )
            : IconButton(
                icon: IconHandler.todo,
                onPressed: () {
                  setState(() {
                    todoPressed = true;
                    messagePressed = false;
                    profilePressed = false;
                    dashboardPressed = false;
                    widget.onTodo();
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
                    todoPressed = false;
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
                    todoPressed = false;
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
