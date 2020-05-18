import 'package:ember/Models/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'all.dart';



class ViewSubjectsToAddStudents extends StatelessWidget {

  final School currentSchool;
  final User currentUser;

  ViewSubjectsToAddStudents({this.currentUser, this.currentSchool});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Subjects',
        hasBackButton: true,
      ),

      body: SafeArea(
        child: StreamBuilder(
                stream: FirebaseDB.getAllCourses(),
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
                      return GenericNavigator(
                        title: snapshot.data.docs[index].data()['subject_name'],
                        trailing: 'Classes',
                        onPressed: () {
                          String subject = snapshot.data.docs[index].data()['subject_name'];
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewClassesToAddStudents(subject: subject, currentUser: currentUser, currentSchool: currentSchool,)));
                        },
                      );
                    }, itemCount: snapshot.data.docs.length,
                    );
                  }
                  else
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ThemeBanner(
                        title: 'No Subjects',
                        description: 'Add Some Subjects...',
                      ),
                    );
                },
              ),
          ),

    );
  }
}
