import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'Components/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';



class ViewClasses extends StatefulWidget {

  final User userToView;
  final Function onRemovePressed;

  ViewClasses({this.userToView, this.onRemovePressed});


  @override
  _ViewClassesState createState() => _ViewClassesState();
}

class _ViewClassesState extends State<ViewClasses> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var userToViewClasses = widget.userToView.classes[index].get();
        return FutureBuilder(
          future: userToViewClasses,
          builder: (context, userClasses) {
            if (userClasses.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: kThemeOrangeFinal,
                ),
              );
            } else if (widget.userToView.classes.length == 0) {
              return ThemeBanner(
                description: 'No Classes Assigned',
              );
            } else if (userClasses.data == null ||
                widget.userToView.classes.length == 0 ||
                widget.userToView.classes.isEmpty) {
              return ThemeBanner(
                description: 'No Classes Assigned',
              );
            }
            Class userClass = Class().fromMap(userClasses.data.data());
            userClass.classReference = userClasses.data.reference;

            return ViewProfileCourseList(
              className: userClass.className,
              onDeletePressed: () async {

                AlertDialogue(
                    context: context,
                    title: 'Are You Sure?',
                    titleColor: Colors.red,
                    description:
                    'You are about to remove ${widget.userToView.fullName} from ${userClass.className} they will'
                        ' not have access to it until you add them in again. ',
                    onContinuePressed: () async {
                      onLoading(context, true);
                      await AdminOperations.removeClassForStudent(
                          student: widget.userToView,
                          withClass: userClass
                      );
                      onLoading(context, false);
                      // setState(() {
                      //   userToViewClasses = widget.userToView.classes.remove(classReference);
                      // });
                      widget.onRemovePressed(userToViewClasses, userClass.classReference);

                      Navigator.pop(context);
                    });

              },
            );
          },
        );
      },
      itemCount: widget.userToView.classes.length,
    );
  }
}
