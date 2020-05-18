
import 'package:ember/StorageHandlers/FileHandlerStub.dart';
import 'package:ember/StorageHandlers/StorageHandler.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';

import '../../Database/all.dart';




class UploadFileMobile extends StatelessWidget {
  final Class userClass;

  UploadFileMobile({this.userClass});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String filename;
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
              description: 'Please pick a file to Upload',
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

            InstructorOperations.addFileToClass(userClass, CourseFile(
              fileName: filename,
              url: storageURL,
              description: description,
            ));
            onLoading(context, false);
            Navigator.pop(context);

          }).put(webFile, fileID);
        }
      }
    }

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Upload File',
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
                    placeholder: 'Pick Your File Name',
                    onSaved: (value) => filename = value,
                    validator: (value) =>
                        value.length <= 0 ? 'Please enter Filename' : null,
                  ),
                  AdminTextField(
                    placeholder: 'Description For File',
                    onSaved: (value) => description = value,
                    validator: (value) =>
                    value.length <= 0 ? 'Please enter Description for material.' : null,
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
