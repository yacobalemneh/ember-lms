import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class AlertDialogue {
  final BuildContext context;
  final String title;

  final Color titleColor;

  final String description;

  final String buttonLabel;

  final Function onContinuePressed;

  AlertDialogue(
      {this.context,
      this.title,
      this.description,
      this.onContinuePressed,
      this.titleColor,
      this.buttonLabel}) {
    showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: kThemeOrangeLabelTextStyle.copyWith(fontSize: 17),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        buttonLabel == null ? 'Continue' : buttonLabel,
        style: kThemeOrangeLabelTextStyle.copyWith(fontSize: 17),
      ),
      onPressed: onContinuePressed,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      titleTextStyle: titleColor == null
          ? kThemeTextStyle
          : kThemeTextStyle.copyWith(color: titleColor),
      content: Text(description),
      contentTextStyle: kThemeDescriptionTextStyle.copyWith(fontSize: 15),
      actionsPadding: EdgeInsets.all(7),
      actions: [
        cancelButton,
        continueButton,
      ],
      buttonPadding: EdgeInsets.symmetric(horizontal: 7),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
