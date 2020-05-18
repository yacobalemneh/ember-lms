import 'package:ember/Components/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnouncementList extends StatelessWidget {
  @override
  final String announcerName;
  final String announcement;

  final Function onPressed;
  final String image;
  final bool canDelete;

  final String announcementDate;

  AnnouncementList(
      {this.announcerName,
      this.announcementDate,
      this.announcement,
      this.onPressed,
      this.image,
      this.canDelete});

  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(3.0),
      child: ThemeContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 7),
                    child: ProfileBlock(
                      title: announcerName,
                      description: announcementDate,
                      image: image,
                    ),
                  ),
                  canDelete == true ?
                  Padding(
                    padding: const EdgeInsets.only(right: 12,),
                    child: NavigationButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: kThemeOrangeFinal,
                      ),
                      onPressed: onPressed,
                    ),
                  ) : SizedBox()
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: Text(
                  announcement,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lato',
                    color: kThemeTextColor,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
