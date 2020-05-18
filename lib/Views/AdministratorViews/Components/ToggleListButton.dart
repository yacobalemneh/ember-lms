import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class ToggleListButton extends StatefulWidget {

  final Widget circleAvatar;
  final String title;

  final bool titleBold;
  final String description;
  final String userId;

  final Function(bool) isToggled;

  bool initialValue;
  ToggleListButton({this.circleAvatar, this.title, this.description, this.isToggled, this.initialValue = false, this.userId, this.titleBold = true});


  @override
  _ToggleListButtonState createState() => _ToggleListButtonState();
}

class _ToggleListButtonState extends State<ToggleListButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.circleAvatar != null ?
              widget.circleAvatar : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(left: 9, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: widget.titleBold ? kThemeTextStyle.copyWith(fontSize: 16) : kThemeTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    widget.description != null ?
                    Text(
                      widget.description,
                      style: kThemeDescriptionTextStyle,
                    ) : SizedBox(),
                    widget.userId != null ?
                    Text(
                      widget.userId,
                      style: kThemeOrangeLabelTextStyle,
                    ) : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          CupertinoSwitch(
            value: widget.initialValue,
            onChanged: (bool isOn) {
              setState(() {
                widget.initialValue = isOn;
                widget.isToggled(isOn);

              });
            },
            activeColor: kThemeOrangeFinal,

          ),
        ],
      ),
    );
  }
}
