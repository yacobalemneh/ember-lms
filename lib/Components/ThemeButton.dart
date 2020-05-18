import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class ThemeButton extends StatelessWidget {


  final buttonLabel;
  final Function onPressed;

  final Color color;
  final Color textColor;

  final double width;

  final EdgeInsetsGeometry padding;


  ThemeButton({this.buttonLabel, this.onPressed, this.color, this.textColor, this.width, this.padding});

  @override
  Widget build(BuildContext context) {
    return !kIsWeb ?
    FractionallySizedBox(
      widthFactor: 0.83,
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: padding == null ? EdgeInsets.only(top: 50.0, bottom: 20.0) : padding,
          child: Container(
            child: Center(
                child: Text(
                    buttonLabel,
                    style: TextStyle(
                      color: textColor == null ? Colors.white : textColor,
                      fontSize: 16.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    )
                )
            ),
            height: 60.0,
            // width: width == null ? 344.0 : width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: color == null ? kThemeOrangeFinal : color,
            ),
          ),
        ),
      ),
    ) :
    Container(
      width: getDeviceWidth(context)/2,
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: padding == null ? EdgeInsets.only(top: 50.0, bottom: 20.0) : padding,
          child: Container(
            child: Center(
                child: Text(
                    buttonLabel,
                    style: TextStyle(
                      color: textColor == null ? Colors.white : textColor,
                      fontSize: 16.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    )
                )
            ),
            height: 60.0,
            width: width == null ? 344.0 : width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: color == null ? kThemeOrangeFinal : color,
            ),
          ),
        ),
      ),
    );

  }


}



