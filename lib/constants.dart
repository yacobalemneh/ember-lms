
import 'package:flutter/foundation.dart' show kIsWeb;


import 'package:flutter/material.dart';


import  'package:intl/intl.dart';


// Device Width and Height

getDeviceWidth (BuildContext context) => MediaQuery.of(context).size.width;

getDeviceHeight (BuildContext context) => MediaQuery.of(context).size.height;

kWebSecondTabWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.655;

const kThemeBlue = Color(0xFF039DFB);

// Theme Colors for Text Field
const kTextFieldShade = Color(0xFFEFEFEF);
const kTextFieldTextColor = Color(0xFFB5B5B5);
const kLoginDescriptionTextColor = Color(0xFFB5B5B5);

//ThemeTitle

const kThemeTitle = Text(
  'ember',
  style: TextStyle (
    fontFamily: 'Pacifico',
    fontSize: 35,
    color: kThemeTextColor,
    fontWeight: FontWeight.w100,
  ),
);


// Theme Colors

MaterialColor kThemeMaterialColor = MaterialColor(0xFFF26719, kTheme);

Map<int, Color> kTheme =
{
  50:Color.fromRGBO(4,131,184, .1),
  100:Color.fromRGBO(4,131,184, .2),
  200:Color.fromRGBO(4,131,184, .3),
  300:Color.fromRGBO(4,131,184, .4),
  400:Color.fromRGBO(4,131,184, .5),
  500:Color.fromRGBO(4,131,184, .6),
  600:Color.fromRGBO(4,131,184, .7),
  700:Color.fromRGBO(4,131,184, .8),
  800:Color.fromRGBO(4,131,184, .9),
  900:Color.fromRGBO(4,131,184, 1),
};

const kThemeOrangeFinal = Color(0xFFF26719);

const kThemeOrange = Color(0xFFe19c18);

const kThemeEmber = Color(0xFFE04E39);

const kThemeShadeOfBlack = Color(0xFF635a54);

const kThemeBackGroundColor = Color(0xFFeee4d7);

const kScaffoldBackGroundColor = Color(0xFFF8F8F8);

//Navigation Bar
const kNavigationIconColor = Color(0xFFCACFD8);


//TextStyles
const kThemeTextStyle = TextStyle(fontSize: 18, color: kThemeTextColor, fontFamily: 'Lato', fontWeight: FontWeight.bold);
const kThemeDescriptionTextStyle = TextStyle(fontSize: 12, color: kThemeDescriptioncolor, fontFamily: 'Lato', fontWeight: FontWeight.w500);
const kThemeOrangeLabelTextStyle = TextStyle(
    color: kThemeOrangeFinal,
    fontSize: 13,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w500
);

//Scaffold Properties

const kScaffoldElevation = 1.5;

//Administrator Themes

const kAdministratorBlue = Colors.lightBlueAccent;

const kThemeTextColor = Color(0xFF3E4554);
// const kThemeDescriptioncolor = Color(0xFFABB2C1);
const kThemeDescriptioncolor = Color(0xFFBEC6D2);


const kThemeGreen = Color(0xFF00C48C);


//Date Format
final dateFormat = new DateFormat.yMMMd('en_US').add_jm();
final dateFormatDay = new DateFormat.yMMMd('en_US');

