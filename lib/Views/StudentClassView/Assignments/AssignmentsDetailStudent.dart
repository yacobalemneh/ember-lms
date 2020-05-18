import 'package:ember/Components/all.dart';
import 'package:ember/Views/StudentClassView/Assignments/SubmitAssignment.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Models/all.dart';

class AssignmentsDetailStudent extends StatelessWidget {
  final Class userClass;
  final User currentUser;
  final Assignment assignment;
  final List<Submission> studentSubmissions;

  final bool submissionStatus;

  AssignmentsDetailStudent(
      {this.assignment,
      this.submissionStatus,
      this.currentUser,
      this.userClass,
      this.studentSubmissions});

  @override
  Widget build(BuildContext context) {

    getStudentGrade() {
      if(studentSubmissions.length > 0 && studentSubmissions[0].receivedGrade != null) {
        double gradePercentage = (studentSubmissions[0].receivedGrade/assignment
            .possibleGrade) * 100;
        return '${studentSubmissions[0].receivedGrade}/${assignment
            .possibleGrade} or $gradePercentage%';
      }
      else
        return 'Not Available';
    }

    getInstructorComments() {
      if(studentSubmissions.length > 0 && studentSubmissions[0].instructorComments != null) {
        return ThemeBanner(
          title: 'Instructor Comments',
          description: studentSubmissions[0].instructorComments,
        );
      }
      else
        return SizedBox();
    }

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Assignment Details',
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Submit',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SubmitAssignment(
                          userClass: userClass,
                          currentUser: currentUser,
                          assignment: assignment,
                        )));
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            AssignmentBanner(
              title: assignment.assignment,
              description: '${assignment.possibleGrade.toString()} pts',
              submissionMessage: assignment.submittedby != null &&
                      assignment.submittedby.contains(currentUser.userId) ==
                          true
                  ? 'Submitted'
                  : null,
            ),
            AssignmentBanner(
              title: 'Due',
              description: DateHandler.standardDate(assignment.due),
              // description: 'Hello',
              submissionMessage: null,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: ThemeBanner(
                title: 'Total Grade',
                trailing: getStudentGrade(),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 10.0, right: 10.0),
            //   child: ThemeBanner(
            //     title: 'Ranking',
            //     trailing: 'Top 3%',
            //     description: 'Better than 97% of students in this class',
            //   ),
            // ),
            DescriptionBanner(
              title: 'Instructions',
              description: assignment.instructions,
            ),
            assignment.url != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ThemeBanner(
                      title: 'Assignment Files',
                      assignmentFiles: 'Click to Open',
                      onAssignmentFileTap: () {
                        URLLauncher(url: assignment.url);
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ThemeBanner(
                      title: 'No Assignment Files',
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ThemeBanner(
                    title: 'Files Submitted',
                  ),
                  studentSubmissions != null && studentSubmissions.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: SubmissionListItem(
                                fileName: studentSubmissions[index]
                                            .submittedFileName !=
                                        null
                                    ? studentSubmissions[index]
                                        .submittedFileName
                                    : studentSubmissions[index].assignmentName,
                                onTime:
                                    studentSubmissions[index].isStudentOnTime,
                                submittedOn: DateHandler.elaborateDate(
                                    studentSubmissions[index]
                                        .studentSubmissionTime),
                                onTap: () {
                                  URLLauncher(
                                      url: studentSubmissions[index]
                                          .submittedFile);
                                },
                              ),
                            );
                          },
                          itemCount: studentSubmissions.length,
                        )
                      : ThemeBanner(
                          description: 'No Submissions Yet.',
                        ),
                  getInstructorComments()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
