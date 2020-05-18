import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class GradeListView extends StatelessWidget {
  final double assignmentGrade;
  final double receivedGrade;
  final String assignmentName;
  final String dueDate;

  GradeListView(
      {this.assignmentGrade, this.receivedGrade, this.assignmentName, this.dueDate});


  getPercent() {
    if(receivedGrade != null && assignmentGrade != null) {
      double percent = (receivedGrade/assignmentGrade) * 100;
      return percent.toString() +'%';
    }
  }

  didPass(double grade, double assignmentGrade) {
    if (grade != null)
      if (grade / assignmentGrade >= 0.5)
        return true;
      else
        return false;
      else
        return false;
  }

  @override
  Widget build(BuildContext context) {

    getPercent();

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: didPass(assignmentGrade, receivedGrade) ? Icon(Icons.check, color: Colors.green,) : Icon(Icons.clear, color: Colors.red,)
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignmentName,
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
                    'Due: ${dueDate.toString()}',
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
          assignmentGrade != null ?
          Column(
            children: [
              Text(
                '$receivedGrade/$assignmentGrade',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Lato',
                  color: kThemeOrangeFinal
                ),
              ),
              Text(
                'or',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: kThemeOrangeFinal
                ),
              ),
              Text(
                getPercent(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Lato',
                    color: kThemeOrangeFinal
                ),
              ),
            ],
          ) :
          Text(
            'Not Graded Yet',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 12,
                fontFamily: 'Lato',
                color: Color(0xFF3E4554)
            ),
          ),

          Align(
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color(0xFFDADEE5),
            ),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );

  }
}
