import 'package:ember/Components/all.dart';
import 'package:ember/IconHandler.dart';
import 'package:ember/Terms.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/material.dart';
import 'package:ember/Models/all.dart';
import 'package:app_settings/app_settings.dart';

class ProfilePageDrawer extends StatelessWidget {
  final User currentUser;

  ProfilePageDrawer({this.currentUser});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.all(7),
            // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            duration: Duration(seconds: 3),
            child: Row(
              children: [
                ThemeCircleAvatar(
                  radius: 30,
                  userName: currentUser.fullName,
                  image: currentUser.image,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentUser.fullName,
                        style: kThemeTextStyle.copyWith(fontSize: 17),
                      ),
                      Text(
                        'User ID: ${currentUser.userId}',
                        style:
                            kThemeDescriptionTextStyle.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
            decoration: ThemeContainer().getThemeDecoration(),
          ),
          ListView(
            padding: EdgeInsets.all(7.0),
            shrinkWrap: true,
            children: [
              ThemeContainer(
                child: Column(
                  children: [
                    GenericNavigator(
                      title: 'Archived Courses',
                      // onPressed: () async => await AppSettings.openWIFISettings(),
                    ),
                    GenericNavigator(
                      title: 'Change Password',
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword()));
                      },
                    ),
                    GenericNavigator(
                      title: 'Notifications',
                      onPressed: () async => await AppSettings.openWIFISettings(),
                    ),

                    currentUser.Role == UserRole.student ?
                    ToggleListButton(
                      title: 'Show Marks',
                      titleBold: false,
                      isToggled: (isOn) {

                        print(isOn);
                      },
                    ) :
                    SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: getDeviceHeight(context) / 4.1,
          ),
          Padding(
            padding: EdgeInsets.all(7.0),
            child: ThemeContainer(
              child: Column(
                children: [
                  GenericNavigator(
                    circleAvatar: IconHandler.logout,
                    title: 'Sign Out',
                    showIcon: false,
                    // onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    onPressed: () {
                      // var count = 0;
                      // Navigator.popUntil(context, (route) {
                      //   return count++ == 2;
                      // });
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Authentication()));
                    },
                  ),
                  GenericNavigator(
                    title: 'About',
                    showIcon: false,
                    onPressed: () async {
                      String terms = await Terms.termsAndConditions;
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AboutDialog(
                              applicationIcon: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: ThemeContainer().getThemeDecoration(),
                                width: 41,
                                child: Image.asset('assets/appIcon.png'),
                              ),
                              applicationName: 'ember',
                              applicationVersion: '1.0.1',
                              applicationLegalese: terms,
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
