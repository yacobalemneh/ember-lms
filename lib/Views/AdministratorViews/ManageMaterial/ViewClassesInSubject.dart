import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:ember/Views/AdministratorViews/Components/all.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';

class ViewClassesInSubject extends StatelessWidget {
  final String subject;

  ViewClassesInSubject({this.subject});

  TextEditingController _controllerOne = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    String className;

    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();
        try {
          await FirebaseDB.addClass(Class(
            className: className,
            subject: subject,
          ));
          _controllerOne.clear();
        } catch (error) {
          print(error.message);
        }
      }
    }

    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Classes in $subject',
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
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: AdminTextField(
                      placeholder: 'Class Name...(Biology 9A, Marketing 101)',
                      controller: _controllerOne,
                      validator: (value) =>
                          value.length < 1 ? 'Please enter a class name' : null,
                      onSaved: (value) => className = value,
                    ),
                  ),
                  NavigationButton(
                    title: 'Add',
                    onPressed: () {
                      onPressed(context);
                    },
                  )
                ],
              ),
              StreamBuilder(
                stream: FirebaseDB.getClassesInSubject(subject),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.data != null &&
                      snapshot.data.docs.length != 0) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GenericNavigator(
                          title: snapshot.data.docs[index].data()['class_name'],
                          trailing: snapshot.data.docs[index]
                                      .data()['instructor_name'] !=
                                  null
                              ? 'Instructor: ' +
                                  snapshot.data.docs[index]
                                      .data()['instructor_name']
                              : 'Assign Instructor',
                          onPressed: () {
                            Class classToAssign = Class()
                                .fromMap(snapshot.data.docs[index].data());
                            classToAssign.classReference =
                                snapshot.data.docs[index].reference;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AssignInstructorToCourse(
                                          toClass: classToAssign,
                                        )));
                          },
                        );
                      },
                      itemCount: snapshot.data.docs.length,
                    );
                  } else
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ThemeBanner(
                        title: 'No Classes',
                        description: 'Add Some Classes...',
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
