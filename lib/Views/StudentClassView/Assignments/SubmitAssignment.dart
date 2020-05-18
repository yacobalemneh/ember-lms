import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';
import 'package:flutter/cupertino.dart';

import 'package:ember/StorageHandlers/FileHandlerStub.dart';
import 'package:ember/StorageHandlers/StorageHandler.dart';

class SubmitAssignment extends StatefulWidget {
  final Class userClass;
  final User currentUser;
  final Assignment assignment;

  SubmitAssignment({this.userClass, this.currentUser, this.assignment});

  @override
  _SubmitAssignmentState createState() => _SubmitAssignmentState();
}

class _SubmitAssignmentState extends State<SubmitAssignment> {
  final formKey = GlobalKey<FormState>();

  String placeHolder;

  bool attachFile = false;
  var submissionFile;

  @override
  Widget build(BuildContext context) {
    String title;
    String submission;


    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();
        if (attachFile == true && submissionFile == null) {
          return AlertDialogue(
              context: context,
              title: 'Didn\'t Attach a file!',
              description: 'Please Attach a file or Enter a Submission.',
              titleColor: kThemeOrangeFinal,
              buttonLabel: 'Attach?',
              onContinuePressed: () async {
                Navigator.pop(context);
                await FileHandler().getFile((file) {
                  submissionFile = file;
                  setState(() {
                    if (submissionFile != null && submissionFile.name != null)
                      placeHolder = submissionFile.name;
                  });
                });
              });
        } else {
          if (attachFile == true && submissionFile != null) {
            onLoading(context, true);

            String fileID = DateTime.now().millisecondsSinceEpoch.toString();
            String folderPath = FirebaseDB.schoolName +
                '/' +
                widget.userClass.className +
                '/assignments/submissions/${widget.currentUser.userId}/$fileID' +
                title;

            StorageHandler(
                storagePath: folderPath,
                onStorageComplete: (storageURL) {
                  FirebaseDB.submitAssignment(
                      widget.userClass,
                      Submission(
                          studentId: widget.currentUser.userId,
                          studentName: widget.currentUser.fullName,
                          submissionTyped: submission,
                          studentDocument: widget.currentUser.userDocument,
                          submittedFile: storageURL,
                          dueDate: widget.assignment.due,
                          assignmentID: widget.assignment.assignmentDocId,
                          possibleGrade: widget.assignment.possibleGrade,
                          assignmentName: widget.assignment.assignment,
                          submittedFileName: submissionFile != null && submissionFile.name != null ? submissionFile.name : null,
                      ));
                  onLoading(context, false);
                  Navigator.pop(context);
                }).put(submissionFile, fileID);
          } else {
            onLoading(context, true);
            FirebaseDB.submitAssignment(
                widget.userClass,
                Submission(
                    studentId: widget.currentUser.userId,
                    studentName: widget.currentUser.fullName,
                    studentDocument: widget.currentUser.userDocument,
                    submissionTyped: submission,
                    submittedFile: null,
                    dueDate: widget.assignment.due,
                    assignmentID: widget.assignment.assignmentDocId,
                    possibleGrade: widget.assignment.possibleGrade,
                    assignmentName: widget.assignment.assignment));
            onLoading(context, false);
            Navigator.pop(context);
          }
        }
      }
    }

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Submit Assignment',
        description: widget.userClass.className,
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Submit',
          onPressed: () {
            onPressed(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                AdminTextField(
                  placeholder: 'Submission Title',
                  onSaved: (value) => title = value,
                  validator: (value) => value.length == 0
                      ? 'Please Enter Submission Title'
                      : null,
                ),
                LargeTextField(
                  placeholder: 'Enter Submission Here or Attach File',
                  validator: attachFile
                      ? null
                      : (value) => value.length == 0
                          ? 'Please Enter Submission or Attach File'
                          : null,
                  onSaved: (value) => submission = value,
                ),
                ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    'Attach File?',
                    style:
                        kThemeTextStyle.copyWith(fontWeight: FontWeight.w500),
                  ),
                  trailing: CupertinoSwitch(
                    value: attachFile,
                    onChanged: (bool isOn) {
                      setState(() {
                        attachFile = isOn;
                      });
                    },
                    activeColor: kThemeOrangeFinal,
                  ),
                ),
                attachFile
                    ? GenericNavigator(
                        title:
                            placeHolder == null ? 'Pick a File' : placeHolder,
                        onPressed: () async {
                          await FileHandler().getFile((file) {
                            submissionFile = file;
                            setState(() {
                              if (submissionFile != null &&
                                  submissionFile.name != null)
                                placeHolder = submissionFile.name;
                            });
                          });
                        },
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
