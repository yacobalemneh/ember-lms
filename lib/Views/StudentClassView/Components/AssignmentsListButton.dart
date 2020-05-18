import 'package:ember/IconHandler.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/material.dart';

class AssignmentListButton extends StatelessWidget {

  final Function onPressed;
  final String buttonTitle;

  final String dueDate;
  final String status;

  final bool submitted;

  AssignmentListButton(
      {this.onPressed, this.buttonTitle, this.dueDate, this.submitted, this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      child: FlatButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
             mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: !submitted ? IconHandler.assignment :
                      Icon(Icons.check, color: Color(0xFF00C48C),)
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buttonTitle,
                      style: TextStyle(
                        color: Color(0xFF3E4554),
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Due: ${dueDate}',
                      style: TextStyle(
                        color: Color(0xFFBEC6D2),
                        fontSize: 13,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

              ],
            ),
            Divider(
              color: kThemeShadeOfBlack,
              height: 0,
              thickness: 0.1,
              indent: 20,
            ),
            Row(
              children: [
                status != null ?
                Text(
                  status,
                  style: kThemeOrangeLabelTextStyle,
                ) :
                SizedBox(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Color(0xFFDADEE5),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
