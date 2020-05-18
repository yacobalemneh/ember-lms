import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/all.dart';

class DashboardTodo extends StatelessWidget {
  final List<Assignment> allAssignments;
  DashboardTodo({this.allAssignments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Column(
          children: [
            Text(
              'To-do',
              style: TextStyle(fontSize: 24, color: Color(0xFF3E4554)),
            ),
          ],
        ),
        backgroundColor: Colors.white,

      ),
      body: SafeArea(
        child: Container(),
      )
    );
  }
}
