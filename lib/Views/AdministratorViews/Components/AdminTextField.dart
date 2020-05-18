import 'package:ember/constants.dart';
import 'package:flutter/material.dart';

class AdminTextField extends StatelessWidget {
  final Function onValueChanged;

  final bool obscureCharacter;
  final TextInputType keyboardType;
  final TextEditingController controller;

  final bool multiLine;
  final double height;

  final Function onTap;
  final Function validator;
  final Function onSaved;

  final String placeholder;
  final EdgeInsets padding;

  final bool autofocus;


  final bool showCursor;

  AdminTextField(
      {this.placeholder,
        this.onValueChanged,
        this.obscureCharacter,
        this.keyboardType,
        this.controller,
        this.padding, this.multiLine, this.height, this.onTap, this.onSaved, this.validator, this.showCursor = true, this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
//          height: height == null ? 60.0 : height,
//          width: getDeviceWidth(context),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: this.placeholder,
              hintStyle: TextStyle(
                  fontSize: 17,
                  color: Color(0xFFABB2C1),
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Lato'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
            obscureText: obscureCharacter == null ? false : obscureCharacter,
            keyboardType:
            keyboardType == null ? TextInputType.text : keyboardType,
            autocorrect: false,
            onChanged: onValueChanged,
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            maxLengthEnforced: false,
//            maxLines: multiLine != true || multiLine == null ? 1 : null,
          maxLines: null,
            onTap: onTap,
            validator: validator,
            onSaved: onSaved,
            showCursor: showCursor,
            autofocus: autofocus,

          ),
        ),
        Divider(
          color: kThemeShadeOfBlack,
          height: 0,
          thickness: 0.05,
          indent: 0,
        )
      ],
    );
  }
}
