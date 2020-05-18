import 'package:ember/Helper/all.dart';
import 'package:ember/Views/AdministratorViews/ManageMaterial/AssignInstructorToCourse.dart';
import 'package:ember/Views/AdministratorViews/all.dart';
import 'package:ember/constants.dart';
import 'package:ember/Models/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Database/all.dart';

class AddParent extends StatelessWidget {

  final User currentUser;
  final School currentSchool;

  AddParent({this.currentUser, this.currentSchool});


  TextEditingController _controllerOne = TextEditingController();

  TextEditingController _controllerTwo = TextEditingController();

  TextEditingController _controllerThree = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  

 


  @override
  Widget build(BuildContext context) {
    String firstName;
    String lastName;
    String email;

    onPressed(context) async {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();

        onLoading(context, true);
        await AdminOperations.addParent(
          parent: Parent(
            firstName: firstName.trim(),
            lastName: lastName.trim(),
            email: email.trim(),
          ),
          forSchool: currentSchool,
        );
        onLoading(context, false);

        _controllerOne.clear();
        _controllerTwo.clear();
        _controllerThree.clear();

        _scaffoldKey.currentState.showSnackBar(getSnackBar('Successfully added $firstName as a Parent'));
      }
    }


    return Scaffold(
      key: _scaffoldKey,
      appBar: ThemeAppBar(
        pageTitle: 'Add Parent',
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
                validator: (value) => value.length <= 0 ? 'Please Enter First Name' : null,
                onSaved: (value) => firstName = value,
              ),
              AdminTextField(
                placeholder: 'Last Name',
                controller: _controllerTwo,
                validator: (value) => value.length <= 0 ? 'Please Enter Last Name' : null,
                onSaved: (value) => lastName = value,
              ),
              AdminTextField(
                placeholder: 'user@email.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value.length <= 0 || !value.contains('@') ? 'Please Enter a Valid Email' : null,
                onSaved: (value) => email = value,
                controller: _controllerThree,
                
              ),
              GenericNavigator(
                title: 'Add Students',
                trailing: '1 Student',
                onPressed: () {

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
