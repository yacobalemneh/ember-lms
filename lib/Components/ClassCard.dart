import 'package:ember/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';

class ClassCard extends StatelessWidget {

  final String title;
  final String instructorName;
  final String averageGrade;
  final Color cardColor;
  final Function onCardPressed;

  ClassCard(
      {this.title,
      this.instructorName,
      this.cardColor,
      this.onCardPressed,
      this.averageGrade});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onCardPressed,
        child: Container(

          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xFFCACFD8).withOpacity(0.375),
              blurRadius: 18,
            )
          ]),
          child: Card(
            shadowColor: Color(0xFFCACFD8).withOpacity(0.375),
            elevation: 3.0,
            color: cardColor == null ? Colors.white : cardColor,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                     decoration: BoxDecoration(
                       color: Color(0xffF26719),
                       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                     ),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.618,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox(
                          child: AutoSizeText(
                            title,
                            minFontSize: 12,
                            // maxFontSize: 18,
                            maxLines: 1,
                            style: TextStyle(
                                color: Color(0xFF3E4554),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          child: AutoSizeText(
                            instructorName == null ? 'Instructor not Assigned' : instructorName,
                            textAlign: TextAlign.center,
                            minFontSize: 8,
                            // maxFontSize: 12,
                            maxLines: 1,
                            style: TextStyle(
                                color: Color(0xFFABB2C1),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          child: AutoSizeText(
                            averageGrade,
                            minFontSize: 5,
                            // maxFontSize: 15,
                            maxLines: 1,
                            style: TextStyle(
                                color: Color(0xFFF26719),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color generateRandomColor() {

    List<Color> colorOptions = [Color(0xffF2C219), Color(0xff19A4F2), Color(0xff7819F2), Color(0xff19F28A)];
    int randmIndex = Random().nextInt(16);

    return Colors.accents[Random().nextInt(Colors.accents.length)];

  }
}
