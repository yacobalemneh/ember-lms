import 'package:ember/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeTextField extends StatelessWidget {
  final Function onValueChanged;

  final bool obscureCharacter;
  final TextInputType keyboardType;
  final TextEditingController controller;

  final String placeholder;
  final EdgeInsets padding;

  final Widget leadingIcon;

  final Function onTap;
  final Function validator;
  final Function onSaved;

  final bool maxLengthEnforced;

  final int maxLines;

  final bool autofocus;



  final Widget trailingIcon;

  ThemeTextField(
      {this.placeholder,
      this.onValueChanged,
      this.obscureCharacter,
      this.keyboardType,
      this.controller,
      this.padding,
      this.leadingIcon, this.onSaved, this.onTap, this.validator, this.autofocus, this.trailingIcon, this.maxLines, this.maxLengthEnforced});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: !kIsWeb ? 385 : null,
      padding: padding == null ? EdgeInsets.only(top: 14.0, left: 30.0, right: 30.0) : padding,
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: kTextFieldShade,
          hintText: this.placeholder,
          hintStyle: TextStyle(
              fontSize: 17,
              color: kThemeDescriptioncolor,
              fontWeight: FontWeight.normal,
              fontFamily: 'Lato'),
          prefixIcon: leadingIcon,
          suffixIcon: trailingIcon,


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
        onTap: onTap,
        validator: validator,
        onSaved: onSaved,
        autofocus: autofocus == null ? false : autofocus,
        maxLengthEnforced: false,
        maxLines: maxLines,


      ),
    );
  }
}
