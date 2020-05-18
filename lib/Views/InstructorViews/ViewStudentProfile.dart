import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/ManageMaterial/ViewSubjects.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/Messages/all.dart';

class ViewStudentProfile extends StatelessWidget {
  final User currentUser;
  final User userToView;

  ViewStudentProfile({this.currentUser, this.userToView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'User Information',
        description: 'Student',
        hasBackButton: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ThemeCircleAvatar(
                      radius: 30,
                      userName: userToView.fullName,
                      image: userToView.image,
                    ),
                  ),
                  Text(
                    userToView.fullName,
                    style: kThemeTextStyle,
                  ),
                  Text(
                    getRole(userToView.role),
                    style: kThemeDescriptionTextStyle.copyWith(fontSize: 15),
                  ),
                  Text(
                    'User ID: ${userToView.userId}',
                    style: kThemeOrangeLabelTextStyle,
                  ),
                ],
              ),
              ThemeButton(
                buttonLabel: 'Contact',
                color: kThemeGreen,
                onPressed: () {
                  ChatId chatId = ChatId.generateChatId(
                      currentUser.userId,
                      userToView.userId);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Messenger(
                            chatId: chatId.id,
                            talkingTo: userToView,
                            currentUser: currentUser,
                          )));

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
