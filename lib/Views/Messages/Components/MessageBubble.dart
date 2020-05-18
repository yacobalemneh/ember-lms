import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class MessageBubble extends StatelessWidget {


  final bool isUser;

  final String message;

  final String date;

  MessageBubble({this.isUser, this.message, this.date});






  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: isUser ? EdgeInsets.only(left: 20, top: 21, right: 21) : EdgeInsets.only(left: 20, top: 21, right: 21),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: isUser ? EdgeInsets.only(
                  top: 13, bottom: 13, right: 9, left: 12) : EdgeInsets.only(
                  top: 13, bottom: 13, right: 12, left: 9),
              child: SelectableText(
                message != null ? message : '',
                textAlign: TextAlign.left,
                style: kThemeTextStyle.copyWith(
                    fontSize: 15,
                    color: isUser ? Colors.white : kThemeTextColor,
                    fontWeight: FontWeight.w500),
              ),
              constraints: BoxConstraints(maxWidth: kIsWeb ? (getDeviceWidth(context) * 2/5) : (getDeviceWidth(context) * 3/4)),
              decoration: BoxDecoration(
                  color: isUser ? kThemeOrangeFinal : Colors.white,
                  borderRadius: BorderRadius.circular(7)),
            ),
            Text(
              date,
              style: kThemeDescriptionTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
