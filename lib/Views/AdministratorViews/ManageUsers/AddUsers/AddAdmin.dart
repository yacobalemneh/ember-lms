import 'package:ember/Database/all.dart';
import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/ManageMaterial/AssignInstructorToCourse.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';

class AddAdmin extends StatelessWidget {

  final User currentUser;
  final School currentSchool;

  AddAdmin({this.currentUser, this.currentSchool});


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

          onLoading(context, true);
          await AdminOperations.addAdmin(
            schoolAdmin: SchoolAdmin(
              firstName: firstName.trim(),
              lastName: lastName.trim(),
              email: email.trim(),
            ),
            forSchool: currentSchool,
          );
          onLoading(context, false);
          _scaffoldKey.currentState.showSnackBar(getSnackBar('Successfully added $firstName as Admin'));


          _controllerOne.clear();
          _controllerTwo.clear();
          _controllerThree.clear();

        }
        catch(error) {
          print(error.message);
        }
      }
    }



    return Scaffold(
      key: _scaffoldKey,
      appBar: ThemeAppBar(
        pageTitle: 'Add Parent',
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Add',
          onPressed: ()  {
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
                onSaved: (value) => firstName = value,
                validator: (value) => value.length == 0 ? 'Please Enter Admin\'s First Name' : null,
              ),
              AdminTextField(
                placeholder: 'Last Name',
                controller: _controllerTwo,
                onSaved: (value) => lastName = value,
                validator: (value) => value.length == 0 ? 'Please Enter Admin\'s Last Name' : null,
              ),
              AdminTextField(
                placeholder: 'user@email.com',
                keyboardType: TextInputType.emailAddress,
                controller: _controllerThree,
                onSaved: (value) => email = value,
                validator: (value) => value.length < 4 || !value.contains('@') ? 'Please Enter a Proper Email' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
