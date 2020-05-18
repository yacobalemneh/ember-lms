import 'package:ember/Models/School.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Views/AdministratorViews/ManageUsers/CreateSchoolAnnouncement.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/StorageHandlers/FileHandlerStub.dart';
import 'package:ember/StorageHandlers/StorageHandler.dart';

Widget _buildItems(School school, User currentUser, BuildContext context) {
  return Expanded(
    child: StreamBuilder(
        stream: FirebaseDB.getSchoolAnnouncements(school),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,));
          } else if (snapshot == null || snapshot.data.docs.length == 0) {
            return ThemeBanner(
              title: '',
              description: 'School Announcements will appear here.',
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            itemBuilder: (context, index) {
              var timestamp = snapshot.data.docs[index].data()['date'].toDate();
              var date = dateFormat.format(timestamp);
              return AnnouncementList(
                announcement: snapshot.data.docs[index].data()['announcement'],
                announcerName: snapshot.data.docs[index].data()['announcer'],
                announcementDate: date.toString(),
                canDelete: currentUser.Role == UserRole.schoolAdmin ? true : false,
                onPressed: () {
                  AlertDialogue(
                      context: context,
                      title: 'Are You Sure?',
                      description:
                          'You are about to delete this announcement and this action cannot be reversed.',
                      titleColor: Colors.red,
                      buttonLabel: 'Delete',
                      onContinuePressed: () async {
                        await FirebaseDB.deleteSchoolAnnouncement(
                            school, snapshot.data.docs[index].id);
                      });
                },
              );
            },
            itemCount: snapshot.data.docs.length,
          );
        }),
  );
}

class ProfilePage extends StatelessWidget {

  final User currentUser;
  final School currentSchool;
  ProfilePage({this.currentUser, this.currentSchool});

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    var profileImage;


    return Scaffold(
      key: _drawerKey,
      appBar: ThemeAppBar(
        pageTitle: 'Profile',
        hasBackButton: false,
        trailing: NavigationButton(
          icon: Icon(Icons.dehaze, size: 30, color: Colors.black,),
          onPressed: () => _drawerKey.currentState.openEndDrawer(),
        ),
      ),
      endDrawer: ProfilePageDrawer(currentUser: currentUser,),
      backgroundColor: kScaffoldBackGroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserProfileBlock(
            userName: currentUser.fullName,
            guardianName: currentUser.parentNames,
            userID: currentUser.userId,
            image: currentUser.image,
            userType: currentUser.role,
            schoolName: currentSchool.schoolName,
            email: currentUser.Role != UserRole.student ? currentUser.email : null,
            onEditPressed: () async {
              await FileHandler().getFile((file) {
                profileImage = file;
                if (profileImage != null) {
                  onLoading(context, true);
                  StorageHandler(
                          storagePath: FirebaseDB.schoolName +
                              '/' +
                              'ProfilePictures' +
                              '/' +
                              currentUser.userId,
                          onStorageComplete: (url) {
                            currentUser.image = url;
                            FirebaseDB.updateProfileImage(
                                currentUser.userId, url);
                            onLoading(context, false);
                          })
                      .put(profileImage,
                          DateTime.now().millisecondsSinceEpoch.toString());
                }
              });
            },
          ),
          Divider(
            height: 0,
            thickness: 0.3,
            color: kThemeDescriptioncolor,
          ),

          currentUser.Role == UserRole.schoolAdmin
              ? GenericNavigator(
                  title: 'Add Announcement',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateSchoolAnnouncement(
                                  currentSchool: currentSchool,
                                )));
                  },
                )
              : SizedBox(),
          _buildItems(currentSchool, currentUser, context),
        ],
      ),
    );
  }
}
