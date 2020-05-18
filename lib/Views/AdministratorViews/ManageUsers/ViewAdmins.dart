import 'package:ember/Components/all.dart';
import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/ProfileViews/AdminView/ViewProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';

class ViewAdmins extends StatelessWidget {

  final User currentUser;
  final School currentSchool;

  ViewAdmins({this.currentUser, this.currentSchool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'School Admins',
        description: '${currentSchool.adminCount} Admins',
        isAdmin: true,
        hasBackButton: true,
        trailing: NavigationButton(
          icon: Icon(
            Icons.add,
            size: 35,
            color: kThemeOrangeFinal,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddAdmin(currentUser: currentUser, currentSchool: currentSchool,)));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: kIsWeb ? getDeviceWidth(context) / 3 : null,
              child: ThemeTextField(
                padding: EdgeInsets.only(left: 5, right: 4, top: 5, bottom: 5),
                placeholder: 'Admin Name...',
                leadingIcon: Icon(Icons.search),
                autofocus: true,
              ),
            ),
            StreamBuilder(
              stream: FirebaseDB.getAllAdmins(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null &&
                    snapshot.data.docs.length != 0) {
                  return ListView.builder(
                    shrinkWrap: true, itemBuilder: (context, index) {
                    return GenericNavigator(
                        circleAvatar: ThemeCircleAvatar(
                          radius: 30,
                          userName: snapshot.data
                              .docs[index].data()['first_name'],
                          image: snapshot.data.docs[index].data()['image'],
                        ),
                        title: snapshot.data.docs[index].data()['first_name'] +
                            ' ' + snapshot.data.docs[index].data()['last_name'],
                        description: getRole(snapshot.data.docs[index].data()['role']),

                        onPressed: () {
                            User admin = User.fromMap(snapshot.data.docs[index].data());
                            admin.userDocument = snapshot.data.docs[index].reference;

                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                ViewProfile(currentUser: currentUser, userToView: admin, currentSchool: currentSchool,)));
                        }
                    );
                  }, itemCount: snapshot.data.docs.length,
                  );
                }
                else
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ThemeBanner(
                      title: 'No School Admins',
                      description: 'Add some Admins',
                    ),
                  );
              },
            ),
          ],
        ),

      ),
    );
  }
}

