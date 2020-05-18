import 'package:ember/constants.dart';
import 'package:flutter/material.dart';


class ListViewItemButton extends StatelessWidget {
  @override

  final Function onPressed;
  final String buttonTitle;
  final String trailing;
  final Widget iconImage;
  final double trailingFontSize;

  ListViewItemButton({this.onPressed, this.buttonTitle, this.iconImage, this.trailing, this.trailingFontSize});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, ),
      color: Colors.white,
      child: Column(
        children: [
          FlatButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: iconImage,
                      width: 25,
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Text(
                      buttonTitle,
                      style: TextStyle(
                          color: Color(0xFF3E4554),
                          fontSize:  16,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: trailing != null ? Text(
                          trailing,
                        style: TextStyle(
                          color: Color(0xFFF26719),
                          fontSize: trailingFontSize == null ? 16 : trailingFontSize,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ) :
                          SizedBox(),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 23, color: Color(0xFFCACFD8),),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Divider(
              color: kThemeShadeOfBlack,
              height: 0,
              thickness: 0.1,
              indent: 20,
            ),
          ),
        ],
      ),
    );
  }
}
