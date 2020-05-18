import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class CreateSchoolAnnouncement extends StatelessWidget {

  final School currentSchool;

  CreateSchoolAnnouncement({this.currentSchool});

  // final TextEditingController _controllerOne = TextEditingController();

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    String announcement;

    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();

        try {

          onLoading(context, true);

          await FirebaseDB.createSchoolAnnouncement(currentSchool, Announcement(
            announcer: currentSchool.schoolName,
            announcement: announcement,
          ));

          onLoading(context, false);
          Navigator.pop(context);

        }
        catch(error) {
          print(error.message);
        }



      }
    }

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Create Announcement',
        description: currentSchool.schoolName,
        hasBackButton: true,
        isAdmin: true,
        trailing: NavigationButton(
          title: 'Post',
          onPressed: () {
            onPressed(context);
          },
        ),
      ),

      body: SafeArea(
        child: Form(
          key: formKey,
          child: Center(
            child: Container(
              width: kIsWeb ? getDeviceWidth(context) / 2.5 : null,
              child: ListView(
                children: [
                  kIsWeb
                      ? SizedBox(
                    height: 20,
                  )
                      : SizedBox(),
                  LargeTextField(
                    padding: kIsWeb ? EdgeInsets.symmetric(vertical: 20) : null,
                    placeholder: 'Announcement...',
                    keyboardType: TextInputType.multiline,
                    multiLine: true,
                    height: 1000,
                    validator: (value) =>
                    value.length == 0 ? 'Please Enter Announcement' : null,
                    onSaved: (value) => announcement = value,
                    autofocus: true,
                  ),
                  kIsWeb
                      ? ThemeButton(
                    buttonLabel: 'Post Announcement',
                    color: kThemeGreen,
                    onPressed: () => onPressed(context),
                  )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
