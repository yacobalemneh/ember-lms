import 'package:ember/Components/all.dart';
import 'package:ember/Views/StudentClassView/Assignments/SubmitAssignment.dart';
import 'package:ember/Views/all.dart';
import 'package:ember/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Database/all.dart';

class AssignmentsDetailInstructor extends StatelessWidget {
  final Class userClass;
  final User currentUser;
  final Assignment assignment;


  AssignmentsDetailInstructor(
      {this.assignment,
        this.currentUser,
        this.userClass,});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Assignment Details',
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Submissions',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewSubmissions(
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

            ),
            AssignmentBanner(
              title: 'Due',
              description: DateHandler.standardDate(assignment.due),
              // description: 'Hello',
              submissionMessage: null,
            ),

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
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: ThemeBanner(
                title: 'Total Submissions',
                trailing: 'Top 3%',
              ),
            ),

          StreamBuilder(
              stream: FirebaseDB.getAllSubmissionsForAssignment(userClass, assignment),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(backgroundColor: kThemeOrange,));
                }
                else if (snapshot.connectionState == ConnectionState.none) {
                  return ThemeBanner(title: 'Waiting for Connection');
                }
                else if (snapshot.hasData && snapshot.data != null && snapshot.data.docs.length > 0) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.docs[index].data();
                      return StudentSubmissionList(
                        circleAvatar: ThemeCircleAvatar(
                          userName: data['student_name'],
                          radius: 20,
                        ),
                        title: data['student_name'],
                        description: DateHandler.elaborateDate(data['submission_time'].toDate()),
                        onTime: data['on_time'],
                        trailing: data['received_grade'] == null ? 'Grade?' : data['received_grade'].toString(),
                        onPressed: () async {
                          onLoading(context, true);
                          var studentDocument = await data['student_document'].get();
                          User student = User.fromMap(studentDocument.data());

                          List<Submission> studentSubmissions = await Submission().getUserSubmissions(userClass, student, assignment);
                          onLoading(context, false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewStudentSubmission(
                                    assignment: assignment,
                                    currentUser: currentUser,
                                    userClass: userClass,
                                    submissions: studentSubmissions,
                                    student: student,
                                  )));

                        },
                      );
                    },
                    itemCount: snapshot.data.docs.length,
                  );
                }
                else
                  return ThemeBanner(title: 'No Submissions Yet.',);

              }),


          ],
        ),
      ),
    );
  }
}
