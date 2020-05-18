import 'package:flutter/material.dart';

class DatePicker {



  static Future<dynamic> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
        selectedDate = picked;
    return selectedDate;
  }
}