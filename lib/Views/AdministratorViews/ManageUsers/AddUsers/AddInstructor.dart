import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/ManageMaterial/AssignInstructorToCourse.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';

class AddInstructor extends StatelessWidget {
  final User currentUser;
  final School currentSchool;

  AddInstructor({this.currentUser, this.currentSchool});

  TextEditingController _controllerOne = TextEditingController();

  TextEditingController _controllerTwo = TextEditingController();

  TextEditingController _controllerThree = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String firstName;
    String lastName;
    String email;

    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();

        try {
          await AdminOperations.addInstructor(
            instructor: Instructor(
              firstName: firstName.trim(),
              lastName: lastName.trim(),
              email: email.trim(),
            ),
            forSchool: currentSchool,
          );
          _controllerOne.clear();
          _controllerTwo.clear();
          _controllerThree.clear();
          _scaffoldKey.currentState.showSnackBar(
              getSnackBar('Successfully added $firstName as an Instructor'));
        } catch (error) {
          print(error.message);
        }
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: ThemeAppBar(
        pageTitle: 'Add Teacher',
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Add',
          onPressed: () {
            onPressed(context);
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdminTextField(
                placeholder: 'First Name',
                controller: _controllerOne,
                validator: (value) => value.length < 1
                    ? 'Please enter Instructors\'s first name'
                    : null,
                onSaved: (value) => firstName = value,
              ),
              AdminTextField(
                placeholder: 'Last Name',
                controller: _controllerTwo,
                validator: (value) => value.length < 1
                    ? 'Please enter Instructors\'s last name'
                    : null,
                onSaved: (value) => lastName = value,
              ),
              AdminTextField(
                placeholder: 'user@email.com',
                keyboardType: TextInputType.emailAddress,
                controller: _controllerThree,
                validator: (value) => !value.contains('@') || value.length < 2
                    ? 'Please Enter a Valid Email'
                    : null,
                onSaved: (value) => email = value,
              ),
              GenericNavigator(
                title: 'Assigned Courses',
                trailing: 'No Courses',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssignInstructorToCourse()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
