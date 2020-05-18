import 'package:ember/IconHandler.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';

import 'package:ember/Database/all.dart';

Widget _buildItems(Class userClass, User user) {
  String post;
  TextEditingController _controller = TextEditingController();

  return Stack(
    children: [
      StreamBuilder(
          stream: FirebaseDB.getDiscussionPosts(
              userClass.subject, userClass.className),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: kThemeOrangeFinal,
                ),
              );
            } else if (snapshot == null ||
                snapshot.data.docs.length == 0) {
              return ThemeBanner(
                title: '',
                description: 'No Discussions in this Class Yet',
              );
            } else
              return Padding(
                padding: const EdgeInsets.only(bottom: 85),
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  addAutomaticKeepAlives: false,
                  itemBuilder: (context, index) {
                    var timestamp =
                    snapshot.data.docs[index].data()['date'].toDate();
                    var date = DateHandler.getDifference(timestamp);
                    return DiscussionBoardBox(
                      user: snapshot.data.docs[index].data()['first_name'] + ' ' +snapshot.data.docs[index].data()['last_name'],
                      isInstructor: snapshot.data.docs[index].data()['role'] == 'instructor' ? true : false,
                      post: snapshot.data.docs[index].data()['post'],
                      date: date,
                      isUser: snapshot.data.docs[index].data()['id'] == user.userId ? true : false,

                    );
                  },
                  itemCount: snapshot.data.docs.length,
                ),
              );
          }),

      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ThemeTextField(
            keyboardType: TextInputType.multiline,
            placeholder: 'Say Something',
            maxLines: null,
            onValueChanged: (value) {
              post = value;
            },
            controller: _controller,
            trailingIcon: IconButton(
              icon: IconHandler.send,
              onPressed: () async {
                try {
                  await FirebaseDB.addDisscussionPost(userClass.subject, userClass.className, DiscussionPost(
                      post: post,
                      first_name: user.first_name,
                      last_name: user.last_name,
                      role: user.role,
                      userId: user.userId
                  ));
                  _controller.clear();

                }
                catch(error) {
                  print(error.message);
                }

              },
            ),
          ),
        ),
      )
    ],
  );
}

class DiscussionBoard extends StatelessWidget {
  final Class userClass;
  final User user;

  TextEditingController _controller = TextEditingController();

  DiscussionBoard({this.userClass, this.user});

  @override
  Widget build(BuildContext context) {

    String post;

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Discussions',
        description: userClass.className,
        hasBackButton: true,
      ),
      body: SafeArea(
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItems(userClass, user),
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ThemeTextField(
                  keyboardType: TextInputType.multiline,
                  placeholder: 'Say Something',
                  maxLines: null,
                  onValueChanged: (value) {
                    post = value;
                  },
                  controller: _controller,
                  trailingIcon: IconButton(
                    icon: IconHandler.send,
                    onPressed: () async {
                      try {
                        await FirebaseDB.addDisscussionPost(userClass.subject, userClass.className, DiscussionPost(
                          post: post,
                          first_name: user.first_name,
                          last_name: user.last_name,
                          role: user.role,
                          userId: user.userId
                        ));
                        _controller.clear();

                      }
                      catch(error) {
                        print(error.message);
                      }

                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DiscussionBoardWeb extends StatelessWidget {

  final Class userClass;
  final User user;

  DiscussionBoardWeb({this.userClass, this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ThemeContainer(
        width: kWebSecondTabWidth(context),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 11, right: 12, top: 17, bottom: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discussions',
                    style: kThemeTextStyle,
                  ),
                ],
              ),
            ),
            _buildItems(userClass, user),

          ],
        ),
      ),
    );
  }
}

