import 'package:ember/Components/ClassCard.dart';
import 'package:ember/Components/WebSideBars/StudentWebSideBar.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Views/InstructorViews/ViewAllStudents.dart';

import 'package:ember/Views/all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';

//List<Course> myCourses = StudentLogInView.myCourses;

class Dashboard extends StatefulWidget {
  final User currentUser;
  final School currentSchool;

  Dashboard({this.currentUser, this.currentSchool});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  int _webIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _onItemTappedWeb(int index) {
    setState(() {
      _webIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _studentWidgetOptions = <Widget>[
      DashboardClasses(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),
      DashboardTodo(),
      InboxView(currentUser: widget.currentUser,),
      ProfilePage(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),
    ];

    List<Widget> _parentWidgetOptions = <Widget>[
      ParentLandingPage(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),
      InboxView(currentUser: widget.currentUser,),
      ProfilePage(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),
    ];

    List<Widget> _instructorWigetOptions = <Widget>[
      DashboardClasses(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),
      ViewAllStudents(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),
      InboxView(currentUser: widget.currentUser,),
      ProfilePage(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),
    ];

    getWidgetOptions() {
      if(widget.currentUser.role == 'student')
        return _studentWidgetOptions.elementAt(_selectedIndex);
      else if (widget.currentUser.role == 'instructor')
        return _instructorWigetOptions.elementAt(_selectedIndex);
      else
        return _parentWidgetOptions.elementAt(_selectedIndex);
    }
    getWidgetOptionsWeb(int index) {
      if(widget.currentUser.role == 'student')
        return _studentWidgetOptions.elementAt(index);
      else if (widget.currentUser.role == 'instructor')
        return _instructorWigetOptions.elementAt(index);
      else
        return _parentWidgetOptions.elementAt(index);
    }


    return Scaffold(
      body: kIsWeb ? Row(
        children: [
          widget.currentUser.role == 'student' ?
          StudentWebSideBar(
            currentUser: widget.currentUser,
            school: widget.currentSchool,
            onDashboard: () {
              setState(() {
                _onItemTappedWeb(0);
              });
            },
            onTodo: () {
              setState(() {
                _onItemTappedWeb(1);
              });
            },
            onMessages: () {
              setState(() {
                _onItemTappedWeb(2);
              });
            },
            onProfile: () {
              setState(() {
                _onItemTappedWeb(3);
              });
            },
          ) : widget.currentUser.role == 'instructor' ?

          InstructorWebSideBar(
            currentUser: widget.currentUser,
            school: widget.currentSchool,
            onDashboard: () {
              setState(() {
                _onItemTappedWeb(0);
              });
            },
            onStudents: () {
              setState(() {
                _onItemTappedWeb(1);
              });
            },
            onMessages: () {
              setState(() {
                _onItemTappedWeb(2);
              });
            },
            onProfile: () {
              setState(() {
                _onItemTappedWeb(3);
              });
            },
          ) :
          ParentWebSideBar(
            currentUser: widget.currentUser,
            school: widget.currentSchool,
            onStudents: () {
              setState(() {
                _onItemTappedWeb(0);
              });
            },
            onMessages: () {
              setState(() {
                _onItemTappedWeb(1);
              });
            },
            onProfile: () {
              setState(() {
                _onItemTappedWeb(2);
              });
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            child: ThemeContainer(
                width: getDeviceWidth(context) - 85,
                height: getDeviceHeight(context),
                child: getWidgetOptionsWeb(_webIndex)
            ),
          ),
        ],
      ) : getWidgetOptions(),

      bottomNavigationBar: !kIsWeb ? BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: kThemeDescriptioncolor,
        elevation: 0,
        items: BottomNavigationBars().getNavigationBar(widget.currentUser.role),
        currentIndex: _selectedIndex,
        selectedItemColor: kThemeOrangeFinal,
        onTap: _onItemTapped,
      ) : null
    );
  }
}


