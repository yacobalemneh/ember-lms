import 'package:ember/Components/all.dart';
import 'package:ember/Views/StudentClassView/Assignments/SubmitAssignment.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';

class LectureDescriptionPage extends StatelessWidget {

  final Class userClass;
  final CourseFile file;


  LectureDescriptionPage({this.file, this.userClass});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Lecture Note: ${file.fileName}',
        description: userClass.className,
        hasBackButton: true,
        trailing: NavigationButton(
          icon: Icon(Icons.delete_forever, color: kThemeOrangeFinal,),
          onPressed: () {
            AlertDialogue(
                context: context,
                title: 'Are You Sure?',
                description: 'You are about to delete this Lecture note, but '
                    'it will still be available in the Files section.',
                titleColor: kThemeOrangeFinal,
                buttonLabel: 'Delete',
                onContinuePressed: () async {
                  onLoading(context, true);
                  await InstructorOperations.deleteLectureNote(userClass, file.fileDocId);
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
              title: 'View Lecture Note',
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
