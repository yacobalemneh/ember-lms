import 'package:ember/Components/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(56);

  final String pageTitle;
  final String description;

  final bool hasBackButton;

  final bool isAdmin;

  final Widget trailing;

  ThemeAppBar({this.pageTitle, this.description, this.hasBackButton, this.trailing, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: kIsWeb ? 0.2 : kScaffoldElevation,
      title: Column(
        children: [
          Text(
            pageTitle,
            style: kThemeTextStyle,
          ),
          description != null ?
          Text(
            description,
            style: isAdmin == false ? kThemeDescriptionTextStyle : kThemeOrangeLabelTextStyle,
          ) : SizedBox(),
        ],
      ),
      backgroundColor: Colors.white,
      // leading: kIsWeb ? TabBarLogo() : hasBackButton ? IconButton(
      //   icon: Icon(
      //     CupertinoIcons.back,
      //     size: 30,
      //     color: Color(0xFF3E4554),
      //   ),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // ) : SizedBox(),
      leading: kIsWeb ? SizedBox() : hasBackButton ? IconButton(
        icon: Icon(
          CupertinoIcons.back,
          size: 30,
          color: Color(0xFF3E4554),
        ),
        onPressed: () {
          if(Navigator.canPop(context))
            Navigator.pop(context);
        },
      ) : SizedBox(),
      actions: [
        trailing != null ? trailing : SizedBox()
      ],
    );
  }
}
