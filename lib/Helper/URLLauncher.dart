import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class URLLauncher {

  final String url;

  URLLauncher({this.url}) {
    _launchURL(url);

  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}


