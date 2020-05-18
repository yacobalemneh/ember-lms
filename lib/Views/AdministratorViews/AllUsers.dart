import 'package:ember/Components/all.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Helper/all.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/Models/all.dart';
import 'package:flutter/foundation.dart';

class ViewAllUsers extends StatefulWidget {

  final User currentUser;
  final School currentSchool;

  ViewAllUsers({this.currentUser, this.currentSchool});

  @override
  _ViewAllUsersState createState() => _ViewAllUsersState();
}

class _ViewAllUsersState extends State<ViewAllUsers> {

  var userStream;

  @override
  void initState() {
    userStream = FirebaseDB.getAllUsers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    String searchTerm;

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Users',
        description:'${widget.currentSchool.totalCount} Users ',
        isAdmin: true,
        hasBackButton: false,

      ),

      backgroundColor: kScaffoldBackGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: kIsWeb ? getDeviceWidth(context) / 3 : null,
              child: ThemeTextField(
                padding: EdgeInsets.only(left: 5, right: 4, top: 5, bottom: 5),
                placeholder: 'User name, ID...',
                autofocus: true,
                onValueChanged: (value) async {
                  searchTerm = value;

                },
                trailingIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    setState(()  {
                      if(searchTerm != null && searchTerm != "" && searchTerm != " ")
                        userStream = FirebaseDB.searchAllUsers(searchTerm);
                      else
                        userStream = FirebaseDB.getAllUsers;
                    });

                  }
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: userStream,
                builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Column(
                      children: [
                        SizedBox(height: getDeviceHeight(context)/3),
                        CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
                      ],
                    ));
                  }

                  else if(snapshot.data != null && snapshot.data.docs.length != 0 && snapshot.connectionState == ConnectionState.active) {
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
                        onPressed: () async {
                          User user = User.fromMap(snapshot.data.docs[index].data());
                          user.userDocument = snapshot.data.docs[index].reference;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewProfile(
                                    currentUser: widget.currentUser,
                                    userToView: user,
                                    currentSchool: widget.currentSchool,
                                  )));
                        }


    );
                    }, itemCount: snapshot.data.docs.length,
                    );
                  }
                  else
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ThemeBanner(
                        title: 'No Users',
                        description: 'Add Users, i.e. Students, Instructors...',
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
