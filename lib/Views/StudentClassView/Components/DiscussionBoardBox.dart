import 'package:flutter/material.dart';
import 'package:ember/constants.dart';


class DiscussionBoardBox extends StatelessWidget {

  DiscussionBoardBox({this.user, this.isInstructor, this.post, this.date, this.isUser});

  final String user;

  final String date;

  final String post;

  final bool isUser;
  final bool isInstructor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isUser == true ? kThemeOrangeFinal : Colors.white,
      padding: EdgeInsets.all(26),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user,
                    style: isUser == true ? kThemeTextStyle.copyWith(fontSize: 16, color: Colors.white) :
                    kThemeTextStyle.copyWith(fontSize: 16),
                  ),

                  Text(
                    date,
                    style: isUser == true ? kThemeDescriptionTextStyle.copyWith(color: Color(0xFFE3E3E3)) : kThemeDescriptionTextStyle,
                  ),
                ],
              ),
              isInstructor == true ?
              Text(
                'Instructor',
                style: kThemeDescriptionTextStyle.copyWith(color: kThemeOrangeFinal, fontSize: 13),
              ) : SizedBox()

            ],
          ),
          SizedBox(height: 6,),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                post,
                style: isUser == true ? kThemeTextStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white) :
                kThemeTextStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
