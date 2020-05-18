import 'package:flutter/material.dart';


class SubmissionStatus extends StatelessWidget {

  final bool submitted;

  SubmissionStatus({this.submitted});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          submitted ? Text('Submitted ', style: TextStyle(fontSize: 13, color: Colors.grey),) : SizedBox(),
          !submitted ? Text('Not Submitted', style: TextStyle(fontSize: 13),) : SizedBox(),
          submitted ? Icon(Icons.check, size: 17, color: Colors.green,) : SizedBox(),
          !submitted ? Icon(Icons.close, size: 17, color: Colors.red,) : SizedBox()
        ],
      ),
    );
  }
}
