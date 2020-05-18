import 'package:ember/Models/School.dart';
import 'package:ember/Views/AdministratorViews/ManageUsers/AddUsers/AddInstructor.dart';
import 'package:ember/Views/AdministratorViews/ManageUsers/AddUsers/AddStudent.dart';
import 'package:ember/Views/AdministratorViews/ManageMaterial/ManageUsersAndProperties.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';

class AdministratorDashboard extends StatefulWidget {

  final User currentUser;
  final School currentSchool;

  AdministratorDashboard({this.currentUser, this.currentSchool});



  @override
  _AdministratorDashboardState createState() => _AdministratorDashboardState();
}



class _AdministratorDashboardState extends State<AdministratorDashboard> {



  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    print(widget.currentSchool.parentCount);

    

    List<Widget> _widgetOptions = <Widget>[
      ManageUsersAndProperties(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),

      ViewAllUsers(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),

      InboxView(currentUser: widget.currentUser,),
      //AddInstructor(),
      ProfilePage(currentUser: widget.currentUser, currentSchool: widget.currentSchool,),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: kThemeDescriptioncolor,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
            ),
            title: Text('Classes', style: kThemeDescriptionTextStyle,),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outline,
            ),
            title: Text('Users', style: kThemeDescriptionTextStyle,),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            title: Text('Messages', style: kThemeDescriptionTextStyle,),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text('Profile', style: kThemeDescriptionTextStyle,),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kThemeOrangeFinal,
        onTap: _onItemTapped,
        // type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
