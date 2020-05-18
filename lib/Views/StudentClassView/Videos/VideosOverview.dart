import 'package:ember/IconHandler.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/all.dart';

import 'package:ember/Database/all.dart';

Widget _buildWidgets(Class userClass) {
  return StreamBuilder(
      stream: FirebaseDB.getAllVideos(
          userClass.subject, userClass.className),
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
            title: 'No Videos for this Course Yet',
            description: 'You\'ll be notified if a Video is added.',
          );
        } else
          return ListView.builder(
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            itemBuilder: (context, index) {
              var timestamp = snapshot.data.docs[index].data()['date'].toDate();
              var date = dateFormat.format(timestamp);
              return GenericNavigator(
                circleAvatar: IconHandler.videos,
                title:
                snapshot.data.docs[index].data()['title'],
                description: date.toString(),

                onPressed: () async {
                  // URLLauncher(
                  //     url: snapshot.data.docs[index].data()['url']);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => VideoMaterialDescriptionPage(
                        video: Video(
                          url: snapshot.data.docs[index].data()['url'],
                          title: snapshot.data.docs[index].data()['title'],
                          description: snapshot.data.docs[index].data()['description'],
                          displayableDate: DateHandler.elaborateDate(snapshot.data.docs[index].data()['date'].toDate()),
                          videoDocId: snapshot.data.docs[index].id,
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

class VideosOverView extends StatelessWidget {

  final Class userClass;
  final User currentUser;

  VideosOverView({this.userClass, this.currentUser});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Videos',
        description: userClass.className,
        hasBackButton: true,
        trailing: currentUser.role == 'instructor' ? NavigationButton(
          title: 'Upload',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => AddVideo(
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

class VideosOverviewWeb extends StatelessWidget {

  final Class userClass;
  final User currentUser;

  VideosOverviewWeb({this.userClass, this.currentUser});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      child: ThemeContainer(
        width: kWebSecondTabWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 11, right: 9, top: 17),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Videos', style: kThemeTextStyle,),
                  currentUser.role == 'instructor' ?
                  NavigationButton(
                    title: 'Upload',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AddVideo(
                            userClass: userClass,
                          )));
                    },
                  ) : SizedBox(),

                ],
              ),
            ),

            _buildWidgets(userClass),

          ],
        ),
      ),
    );
  }
}