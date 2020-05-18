import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/InstructorViews/AddAnnouncement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:ember/Views/StudentClassView/all.dart';
import 'package:intl/intl.dart';

Widget _buildItems(Class userClass, User currentUser, User instructor) {
  return StreamBuilder(
      stream: InstructorOperations.getAnnouncements(userClass),

      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Column(
            children: [
              SizedBox(height: getDeviceHeight(context)/2.5,),
              CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
            ],
          ));
        }
        else if (snapshot == null || snapshot.data.docs.length == 0) {
          return ThemeBanner(
            title: 'No Announcements Yet.',
            description: 'You\'ll be notified if an announcement is added.',
          );
        }


        return ListView.builder (
          shrinkWrap: true,
          addAutomaticKeepAlives: false,
          itemBuilder: (context, index) {
            var timestamp = snapshot.data.docs[index].data()['date'].toDate();
            var date = dateFormat.format(timestamp);
            return AnnouncementList(
              announcement: snapshot.data.docs[index].data()['announcement'],
              announcerName: snapshot.data.docs[index].data()['announcer'],
              image: instructor.image,
              announcementDate: date.toString(),
              canDelete: currentUser.role == 'instructor' ? true : false,
              onPressed: () {
                AlertDialogue(
                  context: context,
                  title: 'Are You Sure?',
                  description: 'You are about to delete this announcement and this action cannot be reversed.',
                  titleColor: Colors.red,
                  buttonLabel: 'Delete',
                  onContinuePressed: () async {
                    await InstructorOperations.deleteAnnouncement(userClass, snapshot.data.docs[index].id);
                  }
                );

              },

            );
          }, itemCount: snapshot.data.docs.length,


        );

      });

}

class Announcements extends StatelessWidget {
  final Class userClass;
  final User currentUser;
  final  User instructor;

  Announcements({this.userClass, this.currentUser, this.instructor});



  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: ThemeAppBar(
          hasBackButton: true,
          pageTitle: 'Announcements',
          description: userClass.className,
          trailing: currentUser.role == 'instructor' ? NavigationButton(
            icon: Icon(
              CupertinoIcons.add,
              size: 40,
              color: kThemeOrangeFinal,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddAnnouncement(
                            userClass: userClass,
                          )));
            },
          ) : SizedBox(),
        ),
        backgroundColor: kScaffoldBackGroundColor,
        body: SafeArea(
            child: _buildItems(userClass, currentUser, instructor),
        ));
  }
}

class AnnouncementsWeb extends StatelessWidget {

  final Class userClass;
  final User currentUser;
  final User instructor;

  AnnouncementsWeb({this.userClass, this.currentUser, this.instructor});

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
                    'Announcements',
                    style: kThemeTextStyle,
                  ),
                  currentUser.role == 'instructor' ?
                  NavigationButton(
                    title: 'Add Announcement',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAnnouncement(
                                userClass: userClass,
                              )));
                    },
                  ) : SizedBox(),
                ],
              ),
            ),
            _buildItems(userClass, currentUser, instructor),
          ],
        ),
      ),
    );
  }
}
