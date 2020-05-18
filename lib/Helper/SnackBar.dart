import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

 getSnackBar(String message) {
   return SnackBar(
     content: Text(
       message,
       textAlign: TextAlign.center,
       style: kThemeDescriptionTextStyle.copyWith(
           color: Colors.white, fontSize: 15),
     ),
     backgroundColor: kThemeGreen,
     elevation: 2.0,
   );
 }



