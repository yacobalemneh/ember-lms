import 'dart:convert';

import 'package:random_string/random_string.dart';
import 'package:ember/Database/all.dart';

import 'package:crypto/crypto.dart';



class UserNameGenerator {

  generateUsername(String firstName, String lastName, String schoolname) async {
    int randomInt = randomBetween(1000, 10000);

    String userId = firstName.substring(0, 2).toLowerCase() +
        lastName.substring(0, 2).toLowerCase() +
        schoolname.substring(0, 2).toLowerCase() +
        randomInt.toString();

    while(await FirebaseDB.userExistsInEmber(userId)) {
      userId = firstName.substring(0, 2).toLowerCase() +
          lastName.substring(0, 2).toLowerCase() +
          schoolname.substring(0, 2).toLowerCase() +
          randomInt.toString();
    }

    return userId;

  }
}

class PasswordGenerator {

  hashPassword(String data) {
    var bytes = utf8.encode(data);         // data being hashed
    var digest = sha256.convert(bytes);
    return digest;

  }

  generatePassword() {
    var pass = randomAlphaNumeric(10);

    return pass;
  }

}
