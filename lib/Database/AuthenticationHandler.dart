import 'package:flutter/cupertino.dart';

import 'FirebaseDB.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Components/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/Views/all.dart';

class AuthenticationHandler {
  signIn(String userId, String password, BuildContext context) async {
    onLoading(context, true);

    bool userExistsInEmber = await FirebaseDB.userExistsInEmber(userId);
    print('Authhandler $userId');
    print(userExistsInEmber);

    if (userExistsInEmber) {
      var userGeneralInfo = await FirebaseDB.getGeneralInfo(userId);

      FirebaseDB.schoolName = userGeneralInfo['school_name'];

      bool userExistsInSchool = await FirebaseDB.userExistsInSchool(userId);

      if (userExistsInSchool) {
        var user = await FirebaseDB.getUserInfo(userId);
        var userDocumentReference =
        await FirebaseDB.getUserDocumentReference(userId);
        User currentUser = User.fromMap(user);
        currentUser.userDocument = userDocumentReference;
        print(currentUser.schoolName);
        var schoolDocument = await FirebaseDB.getSchool(currentUser.schoolName);
        School school = School.fromMap(schoolDocument);

        onLoading(context, false);

        if (currentUser.role == 'student' || currentUser.role == 'instructor') {
          if (currentUser.role == 'student')
            await currentUser.getGuardians(currentUser);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Dashboard(
                        currentUser: currentUser,
                        currentSchool: school,
                      )));
        }
        else if(currentUser.role == 'parent') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Dashboard(
                        currentUser: currentUser,
                        currentSchool: school,
                      )));
        }
        else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AdministratorDashboard(
                        currentUser: currentUser,
                        currentSchool: school,
                      )));
        }
      }
      else {
        onLoading(context, false);
        return AlertDialogue(
          context: context,
          title: 'Username Doesn\'t Exist In School.',
          description: 'Enter a Valid Username',
          buttonLabel: 'Retry?',
          onContinuePressed: () => Navigator.pop(context),
        );
      }
    } else {
      onLoading(context, false);
      return AlertDialogue(
        context: context,
        title: 'Username Does\'nt Exist.',
        description: 'Enter a Valid Username',
        buttonLabel: 'Retry?',
        onContinuePressed: () => Navigator.pop(context),
      );
    }
  }
}
