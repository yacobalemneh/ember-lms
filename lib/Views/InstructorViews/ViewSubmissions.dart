import 'package:ember/Components/all.dart';
import 'package:ember/Helper/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Database/all.dart';

class ViewSubmissions extends StatelessWidget {
  final Class userClass;
  final User currentUser;
  final Assignment assignment;

  ViewSubmissions({this.userClass, this.currentUser, this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: '${assignment.assignment} Submissions',
        description: userClass.className,
        hasBackButton: true,
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseDB.getAllSubmissionsForAssignment(
                  userClass, assignment),
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

              })),
    );
  }
}
