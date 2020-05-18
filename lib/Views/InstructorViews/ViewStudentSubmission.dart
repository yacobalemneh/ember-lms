import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:ember/Models/all.dart';
import 'package:flutter/rendering.dart';

class ViewStudentSubmission extends StatefulWidget {
  final Class userClass;

  final User currentUser;
  final User student;

  final Assignment assignment;
  final List<Submission> submissions;

  ViewStudentSubmission(
      {this.userClass,
      this.currentUser,
      this.student,
      this.assignment,
      this.submissions});

  @override
  _ViewStudentSubmissionState createState() => _ViewStudentSubmissionState();
}

class _ViewStudentSubmissionState extends State<ViewStudentSubmission> {

  final TextEditingController _controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  double gradeValue = 0;


  @override
  Widget build(BuildContext context) {
    String gradeEntered;
    String comments;

    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();
        if(gradeValue != null || gradeEntered != null) {
          onLoading(context, true);
          await FirebaseDB.gradeSubmission(widget.userClass, widget.student, widget.assignment,
              GradedAssignment(
                  assignmentName: widget.assignment.assignment,
                  receivedGrade: double.parse(gradeEntered),
                  possibleGrade: widget.assignment.possibleGrade,
                  due: widget.assignment.due,
                  assignmentId: widget.assignment.assignmentDocId,
                  studentName: widget.student.fullName,
                  studentId: widget.student.userId,
                  studentDocument: widget.student.userDocument,
                  instructorComments: comments,
              ));
          onLoading(context, false);
          Navigator.pop(context);
        }
      }
    }

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: '${widget.assignment.assignment} Submissions',
        description: 'By ${widget.student.fullName}',
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Post Grade',
          onPressed: () {
            onPressed(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SubmissionListItem(
                        fileName:
                            widget.submissions[index].submittedFileName != null
                                ? widget.submissions[index].submittedFileName
                                : widget.submissions[index].assignmentName,
                        onTime: widget.submissions[index].isStudentOnTime,
                        submittedOn: DateHandler.elaborateDate(
                            widget.submissions[index].studentSubmissionTime),
                        response: widget.submissions[index].submissionTyped,
                        onTap: () {
                          URLLauncher(url: widget.submissions[index].submittedFile);
                        },
                      ),
                    );
                  },
                  itemCount: widget.submissions.length,
                ),
                ThemeBanner(
                  title: 'User Slider to Grade',
                ),
                Slider(
                  min: 0,
                  max: widget.assignment.possibleGrade,
                  value: gradeValue,
                  divisions: widget.assignment.possibleGrade.toInt() * 4,
                  label: gradeValue.toString(),
                  onChanged: (value) {
                    setState(() {
                      gradeValue = value;
                      _controller.text = value.toString();
                    });
                  },
                ),
                Center(
                  child: Text(
                      'Current Grade: $gradeValue',
                    style: TextStyle(
                        fontSize: 18,
                        color: gradeValue <= widget.assignment.possibleGrade / 2 ? Colors.red : kThemeGreen,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold
                    )

                  ),
                ),
                ThemeBanner(
                  title: 'Or Enter Below',
                ),
                ThemeTextField(
                  padding: kIsWeb ? EdgeInsets.symmetric(horizontal: 300, vertical: 10) : EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  placeholder: 'Enter Grade Here',
                  onSaved: (value) => gradeEntered = value,
                  validator: gradeValue >= 0 ? null : (value) => value.length == 0 ? 'Please Enter Grade or User Slider.' : null,
                  controller: _controller,
                  keyboardType: TextInputType.number,

                ),
                ThemeTextField(
                  padding: kIsWeb ? EdgeInsets.symmetric(horizontal: 300, vertical: 10) : EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  placeholder: 'Comments on Submission',
                  onSaved: (value) => comments = value,
                  validator: (value) => value.length == 0 ? 'Please enter comments for Submission' : null,

                ),
                ThemeButton(
                  padding: kIsWeb ? EdgeInsets.symmetric(horizontal: 300, vertical: 10) : EdgeInsets.symmetric( vertical: 10),
                  buttonLabel: 'Post Grade',
                  color: kThemeGreen,
                  onPressed: () {


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
