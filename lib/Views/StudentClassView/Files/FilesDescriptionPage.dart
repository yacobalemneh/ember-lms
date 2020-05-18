import 'package:ember/Components/all.dart';
import 'package:ember/Views/StudentClassView/Assignments/SubmitAssignment.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';

class FileDescriptionPage extends StatelessWidget {

  final Class userClass;
  final CourseFile file;


  FileDescriptionPage({this.file, this.userClass});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'File: ${file.fileName}',
        description: userClass.className,
        hasBackButton: true,
        trailing: NavigationButton(
          icon: Icon(Icons.delete_forever, color: kThemeOrangeFinal,),
          onPressed: () {
            AlertDialogue(
                context: context,
                title: 'Are You Sure?',
                description: 'You are about to delete this File, it will be permanently deleted if you continue. ',
                titleColor: kThemeOrangeFinal,
                buttonLabel: 'Delete',
                onContinuePressed: () async {
                  onLoading(context, true);
                  await InstructorOperations.deleteFile(userClass, file.fileDocId);
                  onLoading(context, false);
                  var count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                }
            );
          },
        ),

      ),

      body: SafeArea(
        child: ListView(

          children: [

            DescriptionBanner(
              title: file.fileName,
              description: file.description == null ? 'No Description for Video' : file.description,
              // postedOn: 'Posted On: ${video.displayableDate}',
            ),
            SizedBox(
              height: 23,
            ),
            GenericNavigator(
              title: 'View File',
              onPressed: () {
                URLLauncher(
                    url: file.url);
              },

            ),
          ],
        ),
      ),
    );
  }
}
