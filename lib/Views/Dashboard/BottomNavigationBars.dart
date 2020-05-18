import 'package:ember/constants.dart';
import 'package:flutter/material.dart';
import 'all.dart';
import 'package:ember/Views/all.dart';

class BottomNavigationBars {

  getNavigationBar(String role) {
    if(role == 'student')
      return studentNavigationBar;
    else if (role == 'instructor')
      return instructorNavigationBar;
    else
      return parentNavigationBar;

  }

  get studentNavigationBar {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.library_books,
        ),
        title: Text('Classes'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.today,
        ),
        title: Text('Users'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.message,
        ),
        title: Text('Messages'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        title: Text('Profile'),
      ),
    ];
  }

   get parentNavigationBar {

    return  <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.library_books,
        ),
        title: Text('Classes'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.message,
        ),
        title: Text('Messages'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        title: Text('Profile'),
      ),
    ];

  }

  get instructorNavigationBar {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.library_books,
        ),
        title: Text('Classes'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.people_outline,
        ),
        title: Text('Users'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.message,
        ),
        title: Text('Messages'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        title: Text('Profile'),
      ),
    ];
  }

}