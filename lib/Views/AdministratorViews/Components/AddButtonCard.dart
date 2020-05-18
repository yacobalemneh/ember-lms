import 'package:flutter/material.dart';
import 'package:ember/constants.dart';

class AddButtonCard extends StatelessWidget {

  final String cardTitle;
  final IconData icon;
  final Function onTap;

  AddButtonCard({this.cardTitle, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 20.0,
          shadowColor: Colors.black,
          color: kTextFieldShade,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
                color: kThemeEmber,
              ),
              Center(
                child: Text(
                  cardTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
