import 'package:flutter/material.dart';
import 'package:ember/constants.dart';



void onLoading(BuildContext context, bool loading) {
  if (loading)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: SizedBox(
                width: 30, height: 30, child: CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,)));
      },
    );
  else
    Navigator.pop(context);
}

