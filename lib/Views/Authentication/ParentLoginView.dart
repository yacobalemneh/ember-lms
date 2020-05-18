import 'package:ember/IconHandler.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';

class ParentLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemeBackGroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [

                IconHandler.orangeLogo,
                SizedBox(
                  height: 13,
                ),
                kThemeTitle,


                Text('Learning Management System', style: kThemeDescriptionTextStyle.copyWith(fontSize: 14),),
                SizedBox(
                  height: 17,
                ),

                ThemeTextField(
                  placeholder: 'Email',
                  keyboardType: TextInputType.number,
                  obscureCharacter: false,
                  onValueChanged: (value) {


                  },

                ),
                SizedBox(
                    height: 7
                ),
                ThemeTextField(
                  keyboardType: TextInputType.text,
                  obscureCharacter: true,
                  maxLines: 1,
                  placeholder: 'Password',
                  onValueChanged: (value) {

                  },
                ),
              ],
            ),

            Column(
              children: [
                ThemeButton(
                  buttonLabel: 'Sign In',
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');


                  },
                ),

                LoginPageDivider(
                  placeHolder: 'Not a Parent? Swipe Right',
                )
              ],
            )



          ],
        ),
      ),
    );

  }
}
