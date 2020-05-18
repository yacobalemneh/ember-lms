import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/ManageMaterial/AssignChildToParent/ViewStudentsForParent.dart';
import 'package:ember/Views/AdministratorViews/ManageMaterial/ViewSubjects.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/Views/Messages/all.dart';
import 'package:ember/Views/ProfileViews/AdminView/EditUserEmail.dart';
import 'package:ember/Views/ProfileViews/AdminView/ViewChildren.dart';
import 'package:ember/Views/ProfileViews/AdminView/ViewClasses.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';

class ViewProfile extends StatefulWidget {
  final User currentUser;

  User userToView;

  final School currentSchool;

  ViewProfile({this.currentUser, this.userToView, this.currentSchool});

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ThemeAppBar(
          pageTitle: 'User Information',
          description: '${getRole(widget.userToView.role)}',
          hasBackButton: true,
          trailing: widget.userToView.Role == UserRole.student
              ? NavigationButton(
                  title: 'Add Classes',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewSubjects(
                                  forStudent: true,
                                  student: widget.userToView,
                                )));
                  },
                )
              : widget.userToView.Role == UserRole.parent
                  ? NavigationButton(
                      title: 'Add Children',
                      onPressed: () async {
                        User newParent = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewStudentsForParent(
                                      currentUser: widget.currentUser,
                                      currentSchool: widget.currentSchool,
                                      toParent: widget.userToView,
                                    )));
                        setState(() {
                          widget.userToView = newParent;
                        });
                      },
                    )
                  : SizedBox(),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ThemeCircleAvatar(
                        radius: 30,
                        userName: widget.userToView.fullName,
                        image: widget.userToView.image,
                      ),
                    ),
                    Text(
                      widget.userToView.fullName,
                      style: kThemeTextStyle,
                    ),
                    Text(
                      getRole(widget.userToView.role),
                      style: kThemeDescriptionTextStyle.copyWith(fontSize: 15),
                    ),
                    widget.userToView.role != 'student'
                        ? Column(
                            children: [
                              Text(
                                'User ID: ${widget.userToView.userId}',
                                style: kThemeOrangeLabelTextStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Email: ${widget.userToView.email}',
                                    style: kThemeOrangeLabelTextStyle,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  EditUserEmail(
                                    userToView: widget.userToView,
                                    onResetPressed: (email) {
                                      setState(() {
                                        widget.userToView.email = email;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ],
                          )
                        : Text(
                            'User ID: ${widget.userToView.userId}',
                            style: kThemeOrangeLabelTextStyle,
                          ),
                  ],
                ),
              ),
              Column(
                children: [
                  widget.currentUser.Role == UserRole.schoolAdmin &&
                          widget.userToView.Role == UserRole.student
                      ? ThemeBanner(
                          title: 'Classes',
                          description: widget.userToView.classes.isEmpty
                              ? 'No Classes Assigned'
                              : null,
                        )
                      : SizedBox(),
                  widget.currentUser.Role == UserRole.schoolAdmin &&
                          widget.userToView.Role == UserRole.instructor
                      ? ThemeBanner(
                          title: 'Teaches',
                          description: widget.userToView.classes.isEmpty
                              ? 'No Classes Assigned'
                              : null,
                        )
                      : SizedBox(),
                  widget.currentUser.Role == UserRole.schoolAdmin &&
                          widget.userToView.Role == UserRole.parent
                      ? ThemeBanner(
                          title: 'Children',
                          description: widget.userToView.children.isEmpty
                              ? 'No Children Added for Parent'
                              : null,
                        )
                      : SizedBox(),
                  widget.currentUser.Role == UserRole.schoolAdmin &&
                          widget.userToView.Role == UserRole.parent
                      ? ViewChildren(
                          userToView: widget.userToView,
                          onRemovePressed: (userToViewChildren, child) {
                            setState(() {
                              userToViewChildren =
                                  widget.userToView.children.remove(child);
                            });
                          },
                        )
                      : SizedBox(),
                  widget.currentUser.Role == UserRole.schoolAdmin &&
                          (widget.userToView.Role == UserRole.student ||
                              widget.userToView.Role == UserRole.instructor)
                      ? ViewClasses(
                          userToView: widget.userToView,
                          onRemovePressed: (userToViewClasses, classReference) {
                            setState(() {
                              userToViewClasses = widget.userToView.classes
                                  .remove(classReference);
                            });
                          },
                        )
                      : SizedBox(),
                ],
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    widget.currentUser.userId != widget.userToView.userId
                        ? ThemeButton(
                            padding: kIsWeb
                                ? EdgeInsets.only(
                                    top: 100, left: 300, right: 300)
                                : EdgeInsets.only(top: 100),
                            buttonLabel: 'Contact',
                            color: kThemeGreen,
                            onPressed: () {
                              ChatId chatId = ChatId.generateChatId(
                                  widget.currentUser.userId,
                                  widget.userToView.userId);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Messenger(
                                            chatId: chatId.id,
                                            talkingTo: widget.userToView,
                                            currentUser: widget.currentUser,
                                          )));
                            },
                          )
                        : SizedBox(),
                    widget.currentUser.Role == UserRole.schoolAdmin &&
                            widget.currentUser.userId !=
                                widget.userToView.userId
                        ? ThemeButton(
                            padding: kIsWeb
                                ? EdgeInsets.only(
                                    top: 30, bottom: 30, left: 300, right: 300)
                                : EdgeInsets.symmetric(vertical: 30),
                            buttonLabel: 'Delete User',
                            color: Colors.red,
                            onPressed: () {
                              AlertDialogue(
                                  context: context,
                                  title: 'WARNING! Are You Sure?',
                                  titleColor: Colors.red,
                                  description:
                                      'This Action cannot be reversed and all files associated with the ${widget.currentUser.fullName} will be deleted.',
                                  onContinuePressed: () async {
                                    onLoading(context, true);
                                    await FirebaseDB.deleteUser(
                                        widget.userToView.userId);
                                    onLoading(context, false);
                                    var count = 0;
                                    Navigator.popUntil(context, (route) {
                                      return count++ == 2;
                                    });
                                  });
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
