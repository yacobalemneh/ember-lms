import 'package:ember/Database/all.dart';
import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Views/AdministratorViews/Components/all.dart';


class AddStudent extends StatefulWidget {

  final User currentUser;
  final School currentSchool;

  AddStudent({this.currentUser, this.currentSchool});

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController _controllerOne = TextEditingController();

  TextEditingController _controllerTwo = TextEditingController();
  TextEditingController _controllerThree = TextEditingController();
  TextEditingController _controllerFour = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  String placeHolder = 'Date of birth: dd/MM/YY (Optional)';
  var dateOfBirth;

  @override
  Widget build(BuildContext context) {
    String firstName;
    String lastName;

    String grade;

    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();

        await AdminOperations.addStudent(
          student: Student(
            firstName: firstName.trim(),
            lastName: lastName.trim(),
            grade: grade.trim(),
            birthDay: dateOfBirth
          ),
          forSchool: widget.currentSchool,
        );
        _controllerOne.clear();
        _controllerTwo.clear();
        _controllerThree.clear();
        _controllerFour.clear();
        setState(() {
          placeHolder = 'Date of birth: dd/MM/YY (Optional)';
        });
        _scaffoldKey.currentState.showSnackBar(getSnackBar('Successfully added $firstName as a Student'));
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: ThemeAppBar(
        pageTitle: 'Add Student',
        hasBackButton: true,
        trailing: NavigationButton(
            title: 'Add',
            onPressed: () {
              onPressed(context);
            }),
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
                    ? 'Please enter Student\'s first name'
                    : null,
                onSaved: (value) => firstName = value,
              ),
              AdminTextField(
                placeholder: 'Last Name',
                controller: _controllerTwo,
                validator: (value) => value.length < 1
                    ? 'Please enter Student\'s last name'
                    : null,
                onSaved: (value) => lastName = value,
              ),
              AdminTextField(
                placeholder: placeHolder,
                controller: _controllerThree,
                showCursor: false,
                onTap: () async {
                  dateOfBirth = await DatePicker.selectDate(context);
                  setState(() {
                    placeHolder = dateFormatDay.format(dateOfBirth).toString();
                  });
                },
              ),
              AdminTextField(
                placeholder: 'Grade (Optional)',
                controller: _controllerFour,
                onSaved: (value) => grade = value,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
