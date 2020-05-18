
import 'package:ember/StorageHandlers/FileHandlerStub.dart';
import 'package:ember/StorageHandlers/StorageHandler.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';

import '../../Database/all.dart';



class UploadLecture extends StatelessWidget {
  final Class userClass;

  UploadLecture({this.userClass});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String lectureName;
    String description;

    var webFile;

    String placeHolder;

    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();
        if (webFile == null)
          return AlertDialogue(
              context: context,
              title: 'Did not Pick a file.',
              description: 'Please pick a file to add to Lecture Notes',
              onContinuePressed: () async {
                await FileHandler().getFile((file){
                  webFile = file;
                });
                Navigator.pop(context);
              });
        else {
          onLoading(context, true);

          String fileID = DateTime.now().millisecondsSinceEpoch.toString();
          String folderPath =  FirebaseDB.schoolName + '/' + userClass.className;

          StorageHandler(storagePath: folderPath, onStorageComplete: (storageURL) {

            InstructorOperations.addLectureNotes(userClass, CourseFile(
              fileName: lectureName,
              description: description,
              url: storageURL,
            ));

            onLoading(context, false);
            Navigator.pop(context);

          }).put(webFile, fileID);


        }
      }
    }

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Upload Lecture Note',
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
                    placeholder: 'Title for Note',
                    onSaved: (value) => lectureName = value,
                    validator: (value) =>
                    value.length <= 0 ? 'Please give your note a title.' : null,
                  ),
                  AdminTextField(
                    placeholder: 'Description',
                    onSaved: (value) => description = value,
                    validator: (value) =>
                    value.length <= 0 ? 'Please provide a description.' : null,
                  ),

                  GenericNavigator(
                    title: 'Pick File',
                    onPressed: () async {

                      await FileHandler().getFile((file){
                        webFile = file;
                      });


                    },
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
