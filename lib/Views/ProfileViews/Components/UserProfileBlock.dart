import 'package:ember/Components/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class UserProfileBlock extends StatelessWidget {

  final String userName;
  final String guardianName;
  final String userID;
  final String email;

  final String schoolName;


  final String userType;

  final String image;

  final Function onEditPressed;

  UserProfileBlock({this.userName, this.guardianName, this.userID, this.onEditPressed, this.image, this.userType, this.schoolName, this.email});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 134,
      padding: EdgeInsets.all(13),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              ThemeCircleAvatar(
                radius: 30,
                userName: userName,
                image: image,
              ),
              FlatButton(
                child: Text(
                  'EDIT',
                  style: TextStyle(
                    color: kThemeOrangeFinal,
                    fontFamily: 'Lato',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: onEditPressed,
              )
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 7,
              ),
              Text(
                schoolName,
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lato',
                    color: kThemeGreen,
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lato',
                    color: kThemeTextColor
                ),
              ),
              userType == 'student' && guardianName != null ?
              Text(
                'Guardian: $guardianName',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lato',
                    color: kThemeTextColor
                ),
              ) : SizedBox(),
              Text(
                // userType == 'instructor' || userType == 'parent'  || userType == 'admin' ? 'User ID: $userID' : 'Student ID: $userID',
                userType == 'student' ? 'Student ID: $userID' : 'User ID: $userID',
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lato',
                    color: kThemeDescriptioncolor
                ),
              ),
              email != null ?
              Text(
                email,
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lato',
                    color: kThemeOrangeFinal,
                ),
              ) : SizedBox()


            ],
          )

        ],
      ),
    );
  }
}
