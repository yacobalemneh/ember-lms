import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class Terms {
  // static get termsAndConditions async {
  //   await File('assets/terms.txt').readAsString().then((String contents) {
  //     print(contents);
  //   });
  // }

 static Future<String> get termsAndConditions async {
    String file = await rootBundle.loadString('assets/terms.txt');
    return file;
    // return await rootBundle.loadString('assets/terms.txt');
  }
}
