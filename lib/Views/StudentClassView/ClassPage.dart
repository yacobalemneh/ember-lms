import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/InstructorViews/Attendance/RecordAttendance.dart';
import 'package:ember/Views/StudentClassView/DiscussionBoard.dart';
import 'package:ember/Views/StudentClassView/Quiz/all.dart';
import 'package:ember/Views/StudentClassView/Videos/VideosOverview.dart';
import 'package:ember/Views/StudentClassView/all.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/ListViewItemButton.dart';

import 'package:ember/Database/all.dart';

import 'package:ember/IconHandler.dart';

class ClassPage extends StatefulWidget {
  final Class userClass;
  final User currentUser;
  final School currentSchool;

  final User child;

  ClassPage({this.userClass, this.currentUser, this.currentSchool, this.child});

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  Widget webWidget = SizedBox();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: ThemeAppBar(
            pageTitle: '${widget.userClass.className}',
            description: 'Instructor: ${widget.userClass.instructorName}',
            hasBackButton: true,
            trailing: widget.currentUser.role == 'parent' ||
                    widget.currentUser.role == 'student'
                ? NavigationButton(
                    title: 'Contact',
                    onPressed: () async {
                      if (widget.userClass.instructorId != null ||
                          widget.userClass.instructorName != 'Not Assigned') {
                        ChatId chatId = ChatId.generateChatId(
                            widget.currentUser.userId,
                            widget.userClass.instructorId);
                        onLoading(context, true);

                        User instructor = User.fromMap(
                            await FirebaseDB.getUserInfo(
                                widget.userClass.instructorId));
                        var instructorDocumentReference =
                            await FirebaseDB.getUserDocumentReference(
                                widget.userClass.instructorId);
                        instructor.userDocument = instructorDocumentReference;

                        onLoading(context, false);
                        setState(() {
                          kIsWeb
                              ? webWidget = MessengerWeb(
                                  chatId: chatId.id,
                                  talkingTo: instructor,
                                  currentUser: widget.currentUser,
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Messenger(
                                            chatId: chatId.id,
                                            talkingTo: instructor,
                                            currentUser: widget.currentUser,
                                          )));
                        });
                      } else {
                        return AlertDialogue(
                            context: context,
                            title: 'No Instructor for this Class',
                            description:
                                'Since there\'s no instructor for this class, you can\'t message anyone.',
                            buttonLabel: 'Okay',
                            titleColor: kThemeOrangeFinal,
                            onContinuePressed: () {
                              Navigator.pop(context);
                            });
                      }
                    },
                  )
                : null),

        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                child: ThemeContainer(
                  width: kIsWeb
                      ? getDeviceWidth(context) / 3
                      : getDeviceWidth(context) - 6,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 11, vertical: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Class - ${widget.userClass.className}',
                              style: kThemeTextStyle,
                            ),
                            SizedBox(height: 10,),
                            widget.currentUser.Role != UserRole.instructor ?
                            Text(
                              widget.userClass.aboutClass != null ? widget.userClass.aboutClass : 'Instructor hasn\'t added a description for this Class.',
                              style: kThemeDescriptionTextStyle.copyWith(fontSize: 13.5,),
                            ) :
                            GestureDetector(
                              onTap: () {
                                String description;
                                final formKey = GlobalKey<FormState>();
                                return CustomAlertDialogue(
                                  context: context,
                                  title: 'Update Course Description',
                                  description: 'Post a welcome message or a description of what the Class will cover.',
                                  buttonLabel: 'Post',
                                  titleColor: kThemeGreen,
                                  widget: Form(
                                    key: formKey,
                                    child: LargeTextField(
                                      placeholder: 'Course Description...',
                                      autofocus: true,
                                        validator: (value) => value.length <= 0 ? 'Post cannot be blank.' : null,
                                      onSaved: (value) => description = value,

                                    ),
                                  ),
                                    onContinuePressed: () async {
                                      var form = formKey.currentState;
                                      if(form.validate()) {
                                        form.save();
                                        print(description);
                                        setState(() {
                                          widget.userClass.aboutClass = description;
                                        });
                                        onLoading(context, true);
                                        await InstructorOperations.updateClassDescription(forClass: widget.userClass);
                                        onLoading(context, false);

                                        Navigator.pop(context);
                                      }
                                    }
                                );
                              },
                              child: widget.userClass.aboutClass != null ?
                                Text(
                                '${widget.userClass.aboutClass} \n\nTap to Edit',
                                style: kThemeDescriptionTextStyle.copyWith(fontSize: 13.5),
                              ) :
                                Text(
                                  'You have\'t added a description for this Class, tap to add.',
                                  style: kThemeDescriptionTextStyle.copyWith(fontSize: 13.5, color: kThemeGreen),
                                ),
                            ),
                          ],
                        ),
                      ),
                      ListViewItemButton(
                        buttonTitle: 'Attendance',
                        iconImage: IconHandler.attendance,
                        onPressed: () {
                          setState(() {
                            kIsWeb ? webWidget = ViewAttendanceWeb(
                              userClass: widget.userClass,
                              currentUser: widget.currentUser,
                              currentSchool: widget.currentSchool,
                              child: widget.child,
                            ) :
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAttendance(
                                      userClass: widget.userClass,
                                      currentUser: widget.currentUser,
                                      currentSchool: widget.currentSchool,
                                      child: widget.child,
                                    )));
                          });
                        },
                      ),
                      ListViewItemButton(
                        buttonTitle: 'Assignments',
                        iconImage: IconHandler.assignment,
                        onPressed: () {
                          setState(() {
                            kIsWeb
                                ? webWidget = AssignmentsWeb(
                                    userClass: widget.userClass,
                                    currentUser: widget.currentUser,
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AssignmentsOverview(
                                              userClass: widget.userClass,
                                              currentUser: widget.currentUser,
                                            )));
                          });
                        },
                      ),
                      ListViewItemButton(
                        buttonTitle: 'Grades',
                        iconImage: IconHandler.grade,
                        trailing: '97.6%',
                        onPressed: () {
                          setState(() {
                            kIsWeb
                                ? webWidget = GradesWeb(
                                    userClass: widget.userClass,
                                    currentUser: widget.currentUser,
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Grades(
                                              userClass: widget.userClass,
                                              currentUser: widget.currentUser,
                                            )));
                          });
                        },
                      ),
                      widget.currentUser.role != 'parent' ?
                      Column(
                        children: [
                          ListViewItemButton(
                            buttonTitle: 'Files',
                            iconImage: IconHandler.file,
                            onPressed: () {
                              setState(() {
                                kIsWeb
                                    ? webWidget = FilesOverviewWeb(
                                  userClass: widget.userClass,
                                  currentUser: widget.currentUser,
                                )
                                    : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FilesOverView(
                                          userClass: widget.userClass,
                                          currentUser: widget.currentUser,
                                        )));
                              });
                            },
                          ),
                          ListViewItemButton(
                            buttonTitle: 'Quizzes/Exams',
                            iconImage: IconHandler.quiz,
                            onPressed: () {
                              setState(() {
                                kIsWeb
                                    ? webWidget = QuizOverviewWeb()
                                    : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizOverView()));
                              });
                            },
                          ),
                          ListViewItemButton(
                            buttonTitle: 'Lecture Notes',
                            iconImage: IconHandler.lecture,
                            onPressed: () {
                              setState(() {
                                kIsWeb
                                    ? webWidget = LectureNotesWeb(
                                  userClass: widget.userClass,
                                  currentUser: widget.currentUser,
                                )
                                    : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LectureNotes(
                                          userClass: widget.userClass,
                                          currentUser: widget.currentUser,
                                        )));
                              });
                            },
                          ),
                          ListViewItemButton(
                              buttonTitle: 'Announcements',
                              iconImage: IconHandler.announcement,
                              onPressed: () async {
                                var instructorDocument =
                                await widget.userClass.instructor.get();
                                User instructor =
                                User.fromMap(instructorDocument.data());
                                setState(() {
                                  kIsWeb
                                      ? webWidget = AnnouncementsWeb(
                                    userClass: widget.userClass,
                                    currentUser: widget.currentUser,
                                    instructor: instructor,
                                  )
                                      : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Announcements(
                                            userClass: widget.userClass,
                                            currentUser: widget.currentUser,
                                            instructor: instructor,
                                          )));
                                });
                              }),
                          ListViewItemButton(
                            buttonTitle: 'Videos',
                            iconImage: IconHandler.videos,
                            onPressed: () {
                              setState(() {
                                kIsWeb
                                    ? webWidget = VideosOverviewWeb(
                                  userClass: widget.userClass,
                                  currentUser: widget.currentUser,
                                )
                                    : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideosOverView(
                                          userClass: widget.userClass,
                                          currentUser: widget.currentUser,
                                        )));
                              });
                            },
                          ),
                          ListViewItemButton(
                            buttonTitle: 'Discussions',
                            iconImage: IconHandler.discussions,
                            onPressed: () {
                              setState(() {
                                kIsWeb
                                    ? webWidget = DiscussionBoardWeb(
                                  userClass: widget.userClass,
                                  user: widget.currentUser,
                                )
                                    : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DiscussionBoard(
                                          userClass: widget.userClass,
                                          user: widget.currentUser,
                                        )));
                              });
                            },
                          ),
                        ],
                      ) : SizedBox(),
                      widget.currentUser.Role == UserRole.instructor ?
                      ListViewItemButton(
                        buttonTitle: 'Students',
                        iconImage: Icon(Icons.people, color: kThemeTextColor,),
                        onPressed: () {
                          setState(() {
                            kIsWeb
                                ? webWidget = StudentsInClassWeb(
                              userClass: widget.userClass,
                              currentUser: widget.currentUser,

                            )
                                : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentsInClass(
                                      userClass: widget.userClass,
                                      currentUser: widget.currentUser,

                                    )));
                          });
                        },
                      ) : SizedBox()
                    ],
                  ),
                ),
              ),
              kIsWeb
                  ? VerticalDivider(
                      color: kThemeOrangeFinal,
                      width: 0.2,
                      thickness: 0.1,
                indent: 20,
                endIndent: 20,
                    )
                  : SizedBox(),
              kIsWeb ? buildWebHalf() : SizedBox(),
            ],
          ),
        ));
  }

  buildWebHalf() {
    if (webWidget != SizedBox())
      return webWidget;
    else
      return SizedBox();
  }
}
