

import 'package:intl/intl.dart';

class DateHandler {

  DateTime firstDate;
  DateTime secondDate;


  DateHandler({this.firstDate, this.secondDate});

  static getAssignmentDue(DateTime date) {
    var differenceInDays = date.difference(DateTime.now()).inDays;
    print(differenceInDays);

    if(differenceInDays < 4)
      return 'Due in 3 days';
    else if (differenceInDays < 3)
      return 'Due in 2 days';
    else if (differenceInDays < 2)
      return 'Due Today';
    else
      return null;
  }

  static elaborateDate(DateTime date) {
    return DateFormat.MMMMEEEEd().format(date).toString() + ' at ' + DateFormat.jm().format(date).toString();
  }

  static standardDate(DateTime date) {
   return DateFormat.yMMMd('en_US').add_jm().format(date).toString();
  }

  static getDifference(DateTime firstDate) {

    var differenceInMins = DateTime.now().difference(firstDate).inMinutes;

    var differenceInDays = DateTime.now().difference(firstDate).inDays;

    var differenceInHours = DateTime.now().difference(firstDate).inHours;

    if (differenceInMins < 1)
      return 'Just Now';
    else if (differenceInMins < 60 && differenceInMins > 1)
      return differenceInMins.toString() + 'm';
    else if (differenceInMins > 60 && differenceInDays < 1)
      if(differenceInHours < 5)
        return differenceInHours.toString() + ' hours ago';
      else
        return 'Today at ${DateFormat.jm().format(firstDate).toString()}';

    else if (differenceInDays < 7)
      return DateFormat.EEEE().format(firstDate).toString() + ' at ' + DateFormat.jm('en_US').format(firstDate).toString();
    else if (differenceInDays < 365)
      return DateFormat.Md().format(firstDate).toString() + ' ' + DateFormat.jm('en_US').format(firstDate).toString();
    else
      return DateFormat.yMMMd('en_US').format(firstDate).toString() + ' ' + DateFormat.jm('en_US').format(firstDate).toString() ;



  }

}