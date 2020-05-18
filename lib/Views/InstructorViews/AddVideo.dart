import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddVideo extends StatelessWidget {
  final Class userClass;

  AddVideo({this.userClass});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    String link;
    String title;
    String description;


    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();
        print(description);

        try {
          onLoading(context, true);
          await InstructorOperations.addVideoForClass(userClass, Video(
            title: title,
            url: link,
            description: description,
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
        pageTitle: 'Add Video',
        description: userClass.className,
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Upload',
          onPressed: () {
            onPressed(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  AdminTextField(
                    placeholder: 'Paste Link Here',
                    onSaved: (value) => link = value,
                    validator: (value) =>
                        value.length <= 0 ? 'Please Paste Link' : null,
                  ),
                  AdminTextField(
                    placeholder: 'Title for Video',
                    onSaved: (value) => title = value,
                    validator: (value) =>
                    value.length <= 0 ? 'Please enter title of Video for Students' : null,
                  ),
                  AdminTextField(
                    placeholder: 'Description for Video (Optional)',
                    onSaved: (value) => description = value,

                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
