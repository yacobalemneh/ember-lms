import 'package:ember/Components/all.dart';
import 'package:ember/Views/StudentClassView/Assignments/SubmitAssignment.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';

class VideoMaterialDescriptionPage extends StatelessWidget {

  final Class userClass;
  final Video video;


  VideoMaterialDescriptionPage({this.video, this.userClass});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Video Material: ${video.title}',
        description: userClass.className,
        hasBackButton: true,
        trailing: NavigationButton(
          icon: Icon(Icons.delete_forever, color: kThemeOrangeFinal,),
          onPressed: () {
            AlertDialogue(
                context: context,
                title: 'Are You Sure?',
                description: 'You are about to delete this Video resource and this action cannot be reversed.',
                titleColor: Colors.red,
                buttonLabel: 'Delete',
                onContinuePressed: () async {
                  onLoading(context, true);
                  await InstructorOperations.deleteVideoFromClass(userClass, video.videoDocId);
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
              title: video.title,
              description: video.description == null ? 'No Description for Video' : video.description,
              postedOn: 'Posted On: ${video.displayableDate}',
            ),
            SizedBox(
              height: 23,
            ),
            GenericNavigator(
              title: 'Watch Video',
              onPressed: () {
                URLLauncher(
                    url: video.url);
              },

            ),
          ],
        ),
      ),
    );
  }
}
