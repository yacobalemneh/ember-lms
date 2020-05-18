import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'Components/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';


class EditUserEmail extends StatefulWidget {

  final User userToView;
  final Function onResetPressed;

  EditUserEmail({this.userToView, this.onResetPressed});

  @override
  _EditUserEmailState createState() => _EditUserEmailState();
}

class _EditUserEmailState extends State<EditUserEmail> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.edit, color: Colors.red, size: 23,),
      onTap: () {
        String newEmail;
        final formKey = GlobalKey<FormState>();
        return CustomAlertDialogue(
            context: context,
            title: 'Reset User Email',
            titleColor: kThemeGreen,
            description: 'Are you sure this user requested an Email reset?',
            buttonLabel: 'Reset Email',
            widget: Form(
              key: formKey,
              child: ThemeTextField(
                placeholder: 'Enter New Email',
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 3),
                validator: (value) => value.length <= 0 || !value.contains('@') ? 'Please enter a valid Email' : null,
                onValueChanged: (value) => newEmail = value,
                autofocus: true,
              ),
            ),
            onContinuePressed: () async {
              var form = formKey.currentState;
              if(form.validate()) {
                form.save();
                print(newEmail);
                // setState(() {
                //   widget.userToView.email = newEmail;
                // });
                onLoading(context, true);
                await AdminOperations.changeUserEmail(user: widget.userToView);
                onLoading(context, false);
                widget.onResetPressed(newEmail);
                Navigator.pop(context);

              }
            }
        );
      },
    );
  }
}
