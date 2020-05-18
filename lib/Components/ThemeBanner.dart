import 'package:auto_size_text/auto_size_text.dart';
import 'package:ember/constants.dart';
import 'package:flutter/material.dart';

class ThemeBanner extends StatelessWidget {
  final String title;
  final String description;
  final String trailing;

  final String assignmentFiles;
  final Function onAssignmentFileTap;

  ThemeBanner(
      {this.title, this.description, this.trailing, this.assignmentFiles, this.onAssignmentFileTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 22.0, right: 12, left: 12, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title != null
                  ? SizedBox(
                    child: AutoSizeText(
                        title,
                        minFontSize: 10,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                          color: Color(0xFF3E4554),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  )
                  : SizedBox(),
              SizedBox(
                height: 3,
              ),
              description != null
                  ? AutoSizeText(
                      description,
                      minFontSize: 8,
                      // maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Lato',
                        color: Color(0xFFABB2C1),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : SizedBox(),
              assignmentFiles != null
                  ? GestureDetector(

                    child: Text(
                        assignmentFiles,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Lato',
                          // color: Color(0xFFABB2C1),
                          color: kThemeGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                onTap: onAssignmentFileTap,
                  )
                  : SizedBox(),
            ],
          ),
          trailing != null
              ? AutoSizeText(
                  trailing,
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xFFF26719),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
