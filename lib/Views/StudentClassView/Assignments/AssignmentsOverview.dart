

import 'package:ember/Database/all.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import '../Components/all.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/InstructorViews/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';

Widget _buildWidget(Class userClass, User currentUser) {
  return StreamBuilder(
    stream: FirebaseDB.getAssignmentsForClass(userClass),
    builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: Column(
          children: [
            SizedBox(height: getDeviceHeight(context)/2.5,),
            CircularProgressIndicator(backgroundColor: kThemeOrangeFinal,),
          ],
        ));
      }
      else if(snapshot.data != null && snapshot.data.docs.length != 0) {
        return ListView.builder(
          shrinkWrap: true, itemBuilder: (context, index) {
          var document = snapshot.data.docs;
          var timestamp = document[index].data()['due'].toDate();
          var date = DateHandler.standardDate(timestamp);
          var submittedBy;
          if (document[index].data()['submitted_by'] != null) {
            submittedBy = document[index].data()['submitted_by'].toList();
          }
          else {
            submittedBy = [];
          }
          String status = DateHandler.getAssignmentDue(timestamp);
          print(submittedBy);
          return AssignmentListButton(
            buttonTitle: document[index].data()['assignment'],
            dueDate: date,
            submitted: currentUser.role == 'student' &&  submittedBy.length > 0 && submittedBy.contains(currentUser.userId)  ? true : false,
            status: currentUser.role == 'student' ? status : null,

            onPressed: () async {

              if (currentUser.role == 'student') {
                Assignment assignment = Assignment.fromMap(document[index].data());
                assignment.assignmentDocId = document[index].id;
                List<Submission> assignmentSubmissions = await Submission().getUserSubmissions(userClass, currentUser, assignment);


                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AssignmentsDetailStudent(
                          assignment: assignment,
                          currentUser: currentUser,
                          userClass: userClass,
                          studentSubmissions: assignmentSubmissions,
                        )));
              }

              else {
                Assignment assignment = Assignment.fromMap(document[index].data());
                assignment.assignmentDocId = document[index].id;;


                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AssignmentsDetailInstructor(
                          assignment: assignment,
                          currentUser: currentUser,
                          userClass: userClass,
                        )));


              }

            },

          );
        }, itemCount: snapshot.data.docs.length,
        );
      }
      else
        return Container(
          child: ThemeBanner(
            title: 'No Assignments Yet',
            description: 'You\'ll be notified when Assignments are Added.',
          ),
        );
    },
  );


}

class AssignmentsOverview extends StatelessWidget {

  final Class userClass;
  final User currentUser;

  AssignmentsOverview({this.userClass, this.currentUser});


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: ThemeAppBar(
          pageTitle: 'Assignments',
          description: userClass.className,
          hasBackButton: true,
          trailing: currentUser.role == 'instructor' ? NavigationButton(
            icon: Icon(
              Icons.add,
              size: 35,
              color: kThemeOrangeFinal,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddAssignment(
                            userClass: userClass,
                          )));
            },
          ) : SizedBox(),
        ),
        backgroundColor: kScaffoldBackGroundColor,
        body: SafeArea(
            child:  ListView(
              children: [
                _buildWidget(userClass, currentUser)
              ],
            )
    ),
    );

  }

}

class AssignmentsWeb extends StatelessWidget {

  final Class userClass;
  final User currentUser;

  AssignmentsWeb({this.userClass, this.currentUser});

  @override
  Widget build(BuildContext context) {

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: ThemeContainer(
          width: kWebSecondTabWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                padding: EdgeInsets.only(left: 11, right: 9, top: 17),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Assignments', style: kThemeTextStyle,),
                    currentUser.role == 'instructor' ?
                    NavigationButton(
                      title: 'Create Assignment',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddAssignment(
                                  userClass: userClass,
                                )));

                      },
                    ) : SizedBox(),
                  ],
                ),
              ),

             ListView(
               shrinkWrap: true,
               children: [
                 _buildWidget(userClass, currentUser)
               ],
             ),

            ],
          ),
        ),
      );
    }
}



