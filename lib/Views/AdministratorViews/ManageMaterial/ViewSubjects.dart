import 'package:ember/Models/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';
import 'package:intl/intl.dart';


class ViewSubjects extends StatelessWidget {

  final bool forStudent;

  final User student;

  ViewSubjects({this.forStudent, this.student});

  TextEditingController _controllerOne = TextEditingController();

  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    
    String subject;



    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();
        try {
          await FirebaseDB.addSubject(Subject(
            subjectName: subject.trim()
          ));
          _controllerOne.clear();

        }
        catch(error) {
          print(error.message);
        }
      }
    }
    
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Subject',
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Edit',
          onPressed: () {

          },
        ),
      ),

      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              forStudent == false ?
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: AdminTextField(
                      placeholder: 'Subject Name',
                      controller: _controllerOne,
                      validator: (value) =>
                      value.length < 1 ? 'Please enter a subject name' : null,
                      onSaved: (value) => subject = value,
                    ),
                  ),
                  NavigationButton(
                    title: 'Add',
                    onPressed: () {
                      onPressed(context);
                    },
                  )
                ],
              ) : SizedBox(),
              StreamBuilder(
                stream: FirebaseDB.getAllCourses(),
                builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();

                  }
                  else if(snapshot.data != null && snapshot.data.docs.length != 0) {
                    return ListView.builder(
                      shrinkWrap: true, itemBuilder: (context, index) {
                      return GenericNavigator(
                        title: snapshot.data.docs[index].data()['subject_name'],
                        trailing: 'Classes',
                        onPressed: () {
                          forStudent == false ?
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewClassesInSubject(subject: snapshot.data.docs[index].data()['subject_name'],))) :
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddCoursesForStudent(subject: snapshot.data.docs[index].data()['subject_name'], student: student,)));

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
            ],
          ),
        ),
      ),

    );
  }
}
