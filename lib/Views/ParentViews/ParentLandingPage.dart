import 'package:ember/Components/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';
import 'ChildClasses.dart';

class ParentLandingPage extends StatelessWidget {

  final User currentUser;
  final School currentSchool;
  
  ParentLandingPage({this.currentUser, this.currentSchool});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${currentUser.first_name}!',
                    style: TextStyle(fontSize: 24, color: Color(0xFF3E4554)),
                  ),
                  Text(
                    'Pick a Student’s Profile to track their Progress',
                    style: TextStyle(fontSize: 12, color: Color(0xFFABB2C1)),
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var userToViewChildren = currentUser.children[index].get();
                return FutureBuilder(
                  future: userToViewChildren,
                  builder: (context, userChildren) {
                    if (userChildren.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: Text(
                          'Loading...',
                          style: kThemeOrangeLabelTextStyle,
                        )
                      );
                    } else if (currentUser.children.length == 0) {
                      return ThemeBanner(
                        description: 'No Children Added for Parent',
                      );
                    } else if (userChildren.data == null ||
                        currentUser.children.length == 0 ||
                        currentUser.children.isEmpty) {
                      return ThemeBanner(
                        description: 'No Children Added for Parent',
                      );
                    }
                    var studentReference = userChildren.data.reference;
                    User student = User.fromMap(userChildren.data.data());
                    student.userDocument = studentReference;
                    return GenericNavigator(
                      circleAvatar: ThemeCircleAvatar(
                        userName: student.first_name,
                        image: student.image,
                        radius: 25,
                      ),
                      title: student.fullName,
                      description: 'Normal Standing',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChildClasses(
                                  currentUser: currentUser,
                                  currentSchool: currentSchool,
                                  child: student,

                                )));

                      },

                    );
                  },
                );
              },
              itemCount: currentUser.children.length,
            ),

          ],
        ),
      ),
    );
  }
}


