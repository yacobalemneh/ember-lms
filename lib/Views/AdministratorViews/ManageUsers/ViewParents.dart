import 'package:ember/Components/all.dart';
import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';

class ViewParents extends StatelessWidget {

  final User currentUser;
  final School currentSchool;

  ViewParents({this.currentUser, this.currentSchool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Parents',
        description: '${currentSchool.parentCount} Parents',
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
                context, MaterialPageRoute(builder: (context) => AddParent(currentUser: currentUser, currentSchool: currentSchool,)));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            StreamBuilder(
              stream: FirebaseDB.getAllParents(),
              builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Column(
                    children: [
                      SizedBox(height: getDeviceHeight(context)/2.5,),
                      CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
                    ],
                  ));
                }

                if(snapshot.data != null && snapshot.data.docs.length != 0) {
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
                        trailing: snapshot.data.docs[index].data()['id'].toString(),
                        onPressed: () {
                            User parent = User.fromMap(snapshot.data.docs[index].data());
                            parent.userDocument = snapshot.data.docs[index].reference;
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                ViewProfile(currentUser: currentUser , userToView: parent, currentSchool: currentSchool,)));

                          }


                    );
                  }, itemCount: snapshot.data.docs.length,
                  );
                }
                else
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ThemeBanner(
                      title: 'No Parents',
                      description: 'Add Some Parents...',
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
