import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class ThemeContainer extends StatelessWidget {

  final Widget child;

  final double width;
  final double height;

  final EdgeInsets padding;

  ThemeContainer({this.child, this.width, this.height, this.padding});

  getThemeDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(11)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 2,
          // offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding != null ? padding : null,
      width: width != null ? width : null,
      height: height != null ? height : null,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(11)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            // offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
