import 'package:ember/IconHandler.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LectureListButton extends StatelessWidget {

  final String title;
  final String postDate;

  final Function onPressed;

  LectureListButton({this.title, this.postDate, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 7, bottom: 7),
      color: Colors.white,
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [

                IconHandler.lecture,

                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: kThemeTextColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Lato',
                        fontSize: 15
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Posted on $postDate',
                      style: TextStyle(
                          color: kThemeDescriptioncolor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Lato',
                          fontSize: 13
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(CupertinoIcons.forward, color: kThemeDescriptioncolor,),

          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
