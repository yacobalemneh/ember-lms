
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DateTimePicker {

  static DateTime selectedDate = DateTime.now();
  static TimeOfDay selectedTime = TimeOfDay.now();

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hms();  //"6:00 AM"
    return format.format(dt);
  }

  static selectDate(BuildContext context) async {
    final dateFormat = new DateFormat('yyyy-MM-dd');
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2018, 1),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context),
          child: child,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now()
      );
      if (pickedTime != null) {

        var dateAndTime = dateFormat.format(pickedDate) + ' ' +formatTimeOfDay(pickedTime);

        return DateTime.parse(dateAndTime);

      }

    }

  }

}