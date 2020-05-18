import 'package:ember/Components/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class SubmissionListItem extends StatelessWidget {

  final String fileName;
  final String submittedOn;
  final bool onTime;
  final String response;

  final Function onTap;

  SubmissionListItem({this.onTime, this.submittedOn, this.fileName, this.onTap, this.response});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              onTime ? fileName : '$fileName (Late)',
              style: onTime
                  ? kThemeDescriptionTextStyle.copyWith(
                      color: kThemeGreen, fontSize: 17)
                  : kThemeDescriptionTextStyle.copyWith(
                      color: Colors.red, fontSize: 17),
            ),
            Text(
              submittedOn,
              style: kThemeDescriptionTextStyle,
            ),
            Text(
              'Click to View Submission',
              style: kThemeOrangeLabelTextStyle,
            ),
            SizedBox(
              height: 7,
            ),
            response != null ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Submission Response:',
                  style: kThemeTextStyle.copyWith(fontSize: 14),
                ),
                Text(
                  response,
                  style: kThemeTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.normal),
                ),
              ],
            ) : SizedBox()
          ],
        ),
      ),
    );
  }
}
