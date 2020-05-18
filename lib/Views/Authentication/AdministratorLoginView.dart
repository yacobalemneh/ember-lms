import 'package:ember/Models/School.dart';
import 'package:ember/IconHandler.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/Models/all.dart';

class AdministratorLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemeOrangeFinal,
      body: Center(
        child: Container(
          width: 380,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconHandler.whiteLogo,
                  SizedBox(
                    height: 13,
                  ),
                  kThemeTitle,

                  Text(
                    'Learning Management System',
                    style: kThemeDescriptionTextStyle.copyWith(
                        fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  ThemeTextField(
                    placeholder: 'Email',
                    keyboardType: TextInputType.number,
                    obscureCharacter: false,
                    onValueChanged: (value) {},
                  ),
                  SizedBox(height: 7),
                  ThemeTextField(
                    keyboardType: TextInputType.text,
                    obscureCharacter: true,
                    maxLines: 1,
                    placeholder: 'Password',
                    onValueChanged: (value) {},
                  ),
                ],
              ),
              Column(
                children: [
                  ThemeButton(
                    color: Colors.white,
                    textColor: kThemeOrangeFinal,
                    buttonLabel: 'Sign In',
                    onPressed: () async {
                      onLoading(context, true);
                      var user = await FirebaseDB.getUserInfo('yihonal@gmail.com');
                      var userDocumentReference = await FirebaseDB.getUserDocumentReference('yihonal@gmail.com');
                      var schoolDocument = await FirebaseDB.getSchool(FirebaseDB.schoolName);
                      School school = School.fromMap(schoolDocument);



                      User currentUser = User.fromMap(user);
                      currentUser.userDocument = userDocumentReference;

                      onLoading(context, false);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdministratorDashboard(currentUser: currentUser, currentSchool: school,)));
                    },
                  ),
                  LoginPageDivider(
                    color: Colors.white,
                    placeHolder: 'Not a School Admin? Swipe Right',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
