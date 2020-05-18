import 'package:ember/Views/InstructorViews/UploadLecure.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';


Widget _buildWidgets(Class userClass) {
  return StreamBuilder(
      stream: FirebaseDB.getAllLectureNotes(
          userClass),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Column(
            children: [
              SizedBox(height: getDeviceHeight(context)/2.5,),
              CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
            ],
          ));
        } else if (snapshot == null ||
            snapshot.data.docs.length == 0) {
          return ThemeBanner(
            title: 'No Lecture Notes Yet.',
            description: 'You\'ll be notified if a Lecture Note is added.',
          );
        } else
          return ListView.builder(
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            itemBuilder: (context, index) {
              var timestamp = snapshot.data.docs[index].data()['date'].toDate();
              var date = dateFormat.format(timestamp);
              return LectureListButton(
                title: snapshot.data.docs[index].data()['file_name'],
                postDate: date,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LectureDescriptionPage(
                        file: CourseFile(
                          fileName: snapshot.data.docs[index].data()['file_name'],
                          description: snapshot.data.docs[index].data()['description'],
                          url: snapshot.data.docs[index].data()['url'],
                          displayableDate: DateHandler.elaborateDate(snapshot.data.docs[index].data()['date'].toDate()),
                          fileDocId: snapshot.data.docs[index].id,
                        ),
                        userClass: userClass,
                      )));

                },
              );
            },
            itemCount: snapshot.data.docs.length,
          );
      });
}


class LectureNotes extends StatelessWidget {

    final Class userClass;
    final User currentUser;

    LectureNotes({this.userClass, this.currentUser});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Lecture Notes',
        description: userClass.className,
        hasBackButton: true,
        trailing: currentUser.role == 'instructor' ? NavigationButton(
          icon: Icon(
            Icons.add,
            size: 30,
            color: kThemeOrangeFinal,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => UploadLecture(
                  userClass: userClass,
                )));
          },
        ) : SizedBox(),
      ),
      backgroundColor: kScaffoldBackGroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            _buildWidgets(userClass),
          ],
        ),
      ),
    );
  }
}

class LectureNotesWeb extends StatelessWidget {

  final Class userClass;
  final User currentUser;

  LectureNotesWeb({this.userClass, this.currentUser});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ThemeContainer(
        width: kWebSecondTabWidth(context),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 11, right: 9, top: 17),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Lecture Notes', style: kThemeTextStyle,),
                  currentUser.Role == UserRole.instructor ?
                  NavigationButton(
                    title: 'Add Lecture Note',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => UploadLecture(
                            userClass: userClass,
                          )));
                    },
                  ) : SizedBox(),

                ],
              ),
            ),

            ListView(
              shrinkWrap: true,
              children: [
                _buildWidgets(userClass),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



