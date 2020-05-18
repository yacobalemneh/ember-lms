import 'package:ember/Database/AuthenticationHandler.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/IconHandler.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:intl/intl.dart';

class StudentLogInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();


    String userId;

    print('This => $userId');
    onPressed() async {
      print(userId);
      // AuthenticationHandler().signIn('tehaun3572', null, context);
      // var form = formKey.currentState;
      // if (form.validate()) {
      //   form.save();
      //   print('This => $userId');
      //
      //   try {
      //
      //     AuthenticationHandler().signIn(userId, null, context);
      //
      //   } catch (error) {
      //     return AlertDialogue(
      //         context: context,
      //         title: 'Couldnt Find User',
      //         description: 'Enter a Valid Username');
      //   }
      // }
    }

    return Scaffold(
      //backgroundColor: kThemeBackGroundColor,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              width: 380,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 131,
                          child: Image.asset('assets/appIcon.png'),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        kThemeTitle,
                        Text(
                          'Learning Management System',
                          style:
                              kThemeDescriptionTextStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        ThemeTextField(
                          placeholder: 'Student ID',
                          // keyboardType: TextInputType.number,
                          obscureCharacter: false,
                          validator: (value) => value.length == 0
                              ? "Please Enter ID or Email"
                              : null,
                          onSaved: (value) => userId = value,
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
                  ),
                  Column(
                    children: [
                      ThemeButton(
                        buttonLabel: 'Sign In',
                        onPressed: onPressed
                      ),
                      LoginPageDivider(
                        placeHolder: 'Not a Student? Swipe Right',
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
