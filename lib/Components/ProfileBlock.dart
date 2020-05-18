import 'package:ember/Components/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/material.dart';

class ProfileBlock extends StatelessWidget {

  final String title;
  final String description;
  final String image;

  ProfileBlock({this.title, this.description, this.image});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 7, top: 20),
      child: Row(
        children: [
          ThemeCircleAvatar(
            userName: title,
            image: image,
            radius: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: 7,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    color: Color(0xFF3E4554),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Lato',
                    color: Color(0xFFABB2C1),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
          
        ],
      ),
    );
  }
}
