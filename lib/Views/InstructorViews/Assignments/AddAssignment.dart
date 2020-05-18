import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';

import 'package:ember/StorageHandlers/FileHandlerStub.dart';
import 'package:ember/StorageHandlers/StorageHandler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddAssignment extends StatefulWidget {
  final Class userClass;

  AddAssignment({this.userClass});


  @override
  _AddAssignmentState createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  final formKey = GlobalKey<FormState>();

  DateTime datePicked;
  String placeHolder;
  String filePlaceHolder;

  var webFile;



  @override
  Widget build(BuildContext context) {
    String assignmentName;
    String instructions;
    String assigmentGrade;


    onPressed(context) async {

      var form = formKey.currentState;
      if (form.validate()) {
        form.save();
        if (datePicked != null) {
          if(webFile == null) {
            onLoading(context, true);
            await InstructorOperations.createAssignment(widget.userClass, Assignment(
                assignment: assignmentName,
                instructions: instructions,
                due: datePicked,
                possibleGrade: double.parse(assigmentGrade),
            ));
            onLoading(context, false);
            Navigator.pop(context);

          }
          else {
            try {
              onLoading(context, true);

              String fileID = DateTime.now().millisecondsSinceEpoch.toString();
              String folderPath =  FirebaseDB.schoolName + '/' + widget.userClass.className;

              StorageHandler(storagePath: folderPath, onStorageComplete: (storageURL) async {

                await InstructorOperations.createAssignmentWithFile(
                  forClass: widget.userClass,
                  thisAssignment: Assignment(
                    assignment: assignmentName,
                    instructions: instructions,
                    due: datePicked,
                    possibleGrade: double.parse(assigmentGrade),
                    url: storageURL,
                  ),
                  withFile: CourseFile(
                    fileName: assignmentName,
                    description: instructions,
                    url: storageURL,
                  ),
                );
                // await InstructorOperations.addFileToClass(widget.userClass, CourseFile(
                //   fileName: assignmentName,
                //   description: instructions,
                //   url: storageURL,
                // ));
                //
                // await InstructorOperations.createAssignment(widget.userClass, Assignment(
                //     assignment: assignmentName,
                //     instructions: instructions,
                //     due: datePicked,
                //     possibleGrade: double.parse(assigmentGrade),
                //     url: storageURL

                // ));

                onLoading(context, false);
                Navigator.pop(context);

              }).put(webFile, fileID);
              onLoading(context, false);
              Navigator.pop(context);
            }
            catch (error) {
              print(error);
            }
          }
        }
      }
        else
          return AlertDialogue(
              context: context,
              title: 'You haven\'t picked a due date.',
              description: 'Please Pick a due date so that students know when to submit. ',
              buttonLabel: 'Pick a Date',
              onContinuePressed: () async {
                Navigator.pop(context);
                datePicked = await DateTimePicker.selectDate(context);
              }

          );
    }


    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Create Assignment',
        description: widget.userClass.className,
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Create',
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
                  placeholder: 'Assignment Name',
                  validator: (value) =>
                      value.length == 0 ? 'Please Enter Assignment Name' : null,
                  onSaved: (value) => assignmentName = value,
                ),
                AdminTextField(
                  placeholder: 'Instructions',
                  keyboardType: TextInputType.multiline,
                  validator: (value) =>
                      value.length == 0 ? 'Please Enter Description' : null,
                  onSaved: (value) => instructions = value,
                ),
                AdminTextField(
                  placeholder: 'Assignment Points',
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  value.length == 0 ? 'Please Enter Assignment Grade' : null,
                  onSaved: (value) => assigmentGrade = value,
                ),
                GenericNavigator(
                  title:
                      placeHolder == null ? 'Pick a Due Date' : placeHolder,
                  onPressed: () async {
                    onLoading(context, true);
                    datePicked = await DateTimePicker.selectDate(context);
                    onLoading(context, false);

                    setState(() {
                      placeHolder = DateHandler.elaborateDate(datePicked);
                    });


                  },
                ),
                GenericNavigator(
                  title: filePlaceHolder == null ? 'Attach File (Optional)' : filePlaceHolder,
                  onPressed: () async {
                    await FileHandler().getFile((file){
                      webFile = file;
                      setState(() {
                        filePlaceHolder = webFile.name;
                      });

                    });

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
