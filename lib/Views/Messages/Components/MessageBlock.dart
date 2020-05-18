import 'package:ember/Components/all.dart';
import 'package:ember/IconHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:flutter/widgets.dart';

class MessageBlock extends StatelessWidget {
  final String senderName;
  final String textSample;
  final Function onPressed;
  final bool isRead;
  final String date;

  final String image;



  MessageBlock(
      {this.senderName,
      this.textSample,
      this.onPressed,
      this.isRead,
      this.date, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 6),
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ThemeCircleAvatar(
                  radius: 25,
                  userName: senderName,
                  image: image,

                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      senderName,
                      style: TextStyle(
                        color: kThemeTextColor,
                        fontSize: 15,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      textSample.length < 25 ? textSample : textSample.substring(0, 25) + '...',
                      style: TextStyle(
                        color: isRead ? Colors.blueGrey[700] : Colors.black,
                        fontSize: 13,
                        fontFamily: 'Lato',
                        fontWeight: isRead ? FontWeight.normal : FontWeight.bold

                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),


              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                !isRead ?
                    IconHandler.unread : SizedBox(),
                SizedBox(height: 10,),
                Text(
                  date,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
