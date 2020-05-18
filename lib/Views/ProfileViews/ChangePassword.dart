import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';

class ChangePassword extends StatelessWidget {

  final User currentUser;
  final School school;

  ChangePassword({this.currentUser, this.school});

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {


    String newPasswordsMatch;

    String currentPassword;
    String newPassword;
    String newPasswordVerify;

    onPressed() {
      print(newPassword);
      print(newPasswordVerify);
      print(newPasswordsMatch);
      var form = formKey.currentState;
      if(form.validate()) {
        form.save();
        print('Password Changed');

      }
    }

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Reset Password',
        hasBackButton: true,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 380,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ThemeTextField(
                    maxLines: 1,
                    placeholder: 'Current Password',
                    obscureCharacter: true,
                    validator: (value) => value.length == 0 ? 'Please Enter Current Password' : null,
                    onValueChanged: (value) => currentPassword = value,
                  ),
                  ThemeTextField(
                    maxLines: 1,
                    placeholder: 'New Password',
                    obscureCharacter: true,
                    validator: (value) => value.length == 0 ? 'Please Enter New Password' : null,
                    onValueChanged: (value) => newPassword = newPasswordsMatch = value,
                  ),
                  ThemeTextField(
                    maxLines: 1,
                    placeholder: 'Confirm Password',
                    obscureCharacter: true,
                    validator: (value) {
                      if(value.length == 0)
                        return 'Please Enter New Password';
                      else if(value != newPasswordsMatch)
                        return 'Passwords must match';
                      else
                        return null;
                    },
                    onValueChanged: (value) => newPasswordVerify = value,
                  ),

                  ThemeButton(
                    buttonLabel: 'Change Password',
                    onPressed: () {
                      onPressed();
                    },
                  )
                ],

              ),
            ),
          ),
        ),
      ),

    );
  }
}
