import 'package:ember/Database/AuthenticationHandler.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/IconHandler.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:intl/intl.dart';

class Authentication extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {



    String userId;

    onPressed() async {
      // AuthenticationHandler().signIn('kaalsp8024', null, context);
      // AuthenticationHandler().signIn('begesp8590', null, context); // instructor
      // AuthenticationHandler().signIn('hehasp2439', null, context); // Admin
      // AuthenticationHandler().signIn('rogesp8417', null, context); // Parent
      //
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();

        try {

          AuthenticationHandler().signIn(userId, null, context);

        } catch (error) {
          return AlertDialogue(
              context: context,
              title: 'Couldnt Find User',
              description: 'Enter a Valid Username');
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 380,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: 131,
                        child: Image.asset('assets/appIcon.png'),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Center(child: kThemeTitle),
                      Center(
                        child: Text(
                          'Learning Management System',
                          style:
                          kThemeDescriptionTextStyle.copyWith(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      ThemeTextField(
                        placeholder: 'User ID',
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
                      SizedBox(height: 7),
                      ThemeButton(
                        buttonLabel: 'Sign In',
                        onPressed: () {
                          onPressed();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
