import 'package:ember/StorageHandlers//StorageHandler.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/IconHandler.dart';
import 'package:ember/Views/InstructorViews/all.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';

Widget _buildWidget(Class userClass) {
  return StreamBuilder(
      stream: FirebaseDB.getAllFiles(userClass.subject, userClass.className),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Column(
            children: [
              SizedBox(height: getDeviceHeight(context)/2.5,),
              CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
            ],
          ));
        } else if (snapshot == null || snapshot.data.docs.length == 0) {
          return ThemeBanner(
            title: 'No Files for this Course Yet',
            description: 'You\'ll be notified if a File is added.',
          );
        } else
          return ListView.builder(
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            itemBuilder: (context, index) {
              var timestamp = snapshot.data.docs[index].data()['date'].toDate();
              var date = dateFormat.format(timestamp);
              return GenericNavigator(
                circleAvatar: IconHandler.file,
                title: snapshot.data.docs[index].data()['file_name'],
                description: date.toString(),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FileDescriptionPage(
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

class FilesOverView extends StatelessWidget {
  final Class userClass;
  final User currentUser;

  FilesOverView({this.userClass, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ThemeAppBar(
          pageTitle: 'Files',
          description: userClass.className,
          hasBackButton: true,
          trailing: currentUser.role == 'instructor' ?
          NavigationButton(
            title: 'Upload File',
            onPressed: () {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UploadFileMobile(
                        userClass: userClass,
                      )));
            },
          ) : SizedBox()
        ),
        backgroundColor: kScaffoldBackGroundColor,
        body: SafeArea(child: _buildWidget(userClass)));
  }
}

class FilesOverviewWeb extends StatelessWidget {
  final Class userClass;
  final User currentUser;

  FilesOverviewWeb({this.userClass, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ThemeContainer(
        width: kWebSecondTabWidth(context),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 11, right: 9, top: 17),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Files',
                    style: kThemeTextStyle,
                  ),
                  currentUser.Role == UserRole.instructor ?
                  NavigationButton(
                    title: 'Upload',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadFileMobile(
                                userClass: userClass,
                              )));
                    },
                  ) : SizedBox(),
                ],
              ),
            ),
            _buildWidget(userClass),
          ],
        ),
      ),
    );
  }
}
