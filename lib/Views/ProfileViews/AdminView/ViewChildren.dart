import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'Components/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';


class ViewChildren extends StatefulWidget {

  final User userToView;
  final Function onRemovePressed;

  ViewChildren({this.userToView, this.onRemovePressed});

  @override
  _ViewChildrenState createState() => _ViewChildrenState();
}

class _ViewChildrenState extends State<ViewChildren> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var userToViewChildren = widget.userToView.children[index].get();
        return FutureBuilder(
          future: userToViewChildren,
          builder: (context, userChildren) {
            if (userChildren.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: kThemeOrangeFinal,
                ),
              );
            } else if (widget.userToView.children.length == 0) {
              return ThemeBanner(
                description: 'No Children Added for Parent',
              );
            } else if (userChildren.data == null ||
                widget.userToView.children.length == 0 ||
                widget.userToView.children.isEmpty) {
              return ThemeBanner(
                description: 'No Children Added for Parent',
              );
            }
            var studentReference = userChildren.data.reference;
            User student = User.fromMap(userChildren.data.data());
            student.userDocument = studentReference;
            return ViewProfileCourseList(
              className: student.fullName,
              onDeletePressed: () async {
                AlertDialogue(
                    context: context,
                    title: 'Are You Sure?',
                    titleColor: Colors.red,
                    description: 'You are about to revoke ${widget.userToView.fullName}\'s status as a guardian to'
                        ' ${student.fullName}, do you want to continue?',
                    onContinuePressed: () async {
                      onLoading(context, true);
                      await AdminOperations.disassociateParentAndStudent(parent: widget.userToView, student: student);
                      onLoading(context, false);
                      setState(() {
                        userToViewChildren = widget.userToView.children.remove(studentReference);
                      });
                      widget.onRemovePressed(userToViewChildren, studentReference);

                      Navigator.pop(context);
                    });
              },
            );
          },
        );
      },
      itemCount: widget.userToView.children.length,
    );
  }
}
