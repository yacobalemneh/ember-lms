import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class AddAnnouncement extends StatelessWidget {
  Class userClass;

  AddAnnouncement({this.userClass});

  TextEditingController _controllerOne = TextEditingController();

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
          InstructorOperations.addAnnouncement(
              userClass,
              Announcement(
                announcement: announcement,
                announcer: userClass.instructorName,
              ));
          onLoading(context, false);
          Navigator.pop(context);
        } catch (error) {
          print(error.message);
        }
      }
    }

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Create Announcement',
        description: userClass.className,
        hasBackButton: true,
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
