import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class StudentSubmissionList extends StatelessWidget {
  final String title;
  final String trailing;
  final Color trailingColor;
  final String description;
  final Function onPressed;
  final Widget circleAvatar;

  final bool onTime;

  final bool showIcon;

  StudentSubmissionList(
      {this.title,
        this.trailing,
        this.onPressed,
        this.circleAvatar,
        this.description,
        this.trailingColor,
        this.showIcon = true,
        this.onTime,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      // height: 60,
      color: Colors.white,
      child: FlatButton(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                circleAvatar != null
                    ? Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: circleAvatar)
                    : SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kThemeTextColor,
                      ),
                    ),
                    description != null
                        ? Text(description,
                        style: kThemeDescriptionTextStyle.copyWith(
                            fontSize: 14))
                        : SizedBox(),
                    Text(
                      onTime ? 'Submitted On Time' : 'Submitted Late',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 13,
                        color: onTime ? kThemeGreen : Colors.red,
                      ),
                    ),


                  ],
                ),

              ],
            ),
            Row(
              children: [
                trailing != null
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    trailing,
                    style: kThemeOrangeLabelTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: trailingColor != null
                            ? trailingColor
                            : kThemeOrangeFinal),
                  ),
                )
                    : SizedBox(),
                showIcon ?
                Icon(
                  CupertinoIcons.forward,
                  size: 25,
                  color: kThemeDescriptioncolor,
                ) : SizedBox()
              ],
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}