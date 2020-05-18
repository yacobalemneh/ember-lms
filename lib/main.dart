import 'package:ember/Database/all.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseDB.initializeDefault();
  runApp(Ember());
}

class Ember extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/authentication': (context) => Authentication(),
        '/dashboard' : (context) => Dashboard(),
        '/classview' : (context) => ClassPage(),
        '/administrator' : (context) => AdministratorDashboard(),
        '/viewStudents' : (context) => ViewStudents(),
        '/viewTeachers' : (context) => ViewTeachers(),
        '/viewAllUsers' : (context) => ViewAllUsers(),

      },
      title: 'ember',
      theme: ThemeData(
        primarySwatch: kThemeMaterialColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Authentication(),
    );
  }
}


