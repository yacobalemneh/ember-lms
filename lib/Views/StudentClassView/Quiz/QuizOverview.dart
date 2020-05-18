import 'package:ember/IconHandler.dart';
import 'package:ember/Views/all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ember/constants.dart';
import 'package:ember/Components/all.dart';
import 'package:ember/Models/all.dart';

class QuizOverView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(
        pageTitle: 'Quizzes',
        description: ' - 9A',
        hasBackButton: true,
        trailing: NavigationButton(
          title: 'Create Quiz',
          onPressed: () {
            print('Instructor Add Quiz');
          },
        ),
      ),
      backgroundColor: kScaffoldBackGroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            ListViewItemButton(
              buttonTitle: 'Quiz 1',
              iconImage: IconHandler.quiz,
              onPressed: () {
                AlertDialogue(
                    context: context,
                    title: "This is a timed Assignment",
                    description:
                    "Once you start, you can't quit. Are you sure you want to go ahead? ",
                    onContinuePressed: () {
                      print('Hello');
                    });

              },
            ),
            ListViewItemButton(
              buttonTitle: 'Quiz 2',
              iconImage: IconHandler.quiz,
              onPressed: () {
                AlertDialogue(
                    context: context,
                    title: "This is a timed Assignment",
                    description:
                    "Once you start, you can't quit. Are you sure you want to go ahead? ",
                    onContinuePressed: () {
                      print('Hello');
                    });

              },
            ),
            ListViewItemButton(
              buttonTitle: 'Quiz 3',
              iconImage: IconHandler.quiz,
              onPressed: () {
                AlertDialogue(
                    context: context,
                    title: "This is a timed Assignment",
                    description:
                    "Once you start, you can't quit. Are you sure you want to go ahead? ",
                    onContinuePressed: () {
                      print('Hello');
                    });

              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuizOverviewWeb extends StatelessWidget {


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
                  Text('Quizzes', style: kThemeTextStyle,),
                  NavigationButton(
                    title: 'Add Quiz',
                    onPressed: () {
                      print('Instructor Adds Quiz');
                    },
                  ),

                ],
              ),
            ),

            ListView(
              shrinkWrap: true,
              children: [
                ListViewItemButton(
                  buttonTitle: 'Quiz 1',
                  iconImage: IconHandler.quiz,
                  onPressed: () {
                    AlertDialogue(
                        context: context,
                        title: "This is a timed Assignment",
                        description:
                        "Once you start, you can't quit. Are you sure you want to go ahead? ",
                        onContinuePressed: () {
                          print('Hello');
                        });

                  },
                ),
                ListViewItemButton(
                  buttonTitle: 'Quiz 1',
                  iconImage: IconHandler.quiz,
                  onPressed: () {
                    AlertDialogue(
                        context: context,
                        title: "This is a timed Assignment",
                        description:
                        "Once you start, you can't quit. Are you sure you want to go ahead? ",
                        onContinuePressed: () {
                          print('Hello');
                        });

                  },
                ),
                ListViewItemButton(
                  buttonTitle: 'Quiz 1',
                  iconImage: IconHandler.quiz,
                  onPressed: () {
                    AlertDialogue(
                        context: context,
                        title: "This is a timed Assignment",
                        description:
                        "Once you start, you can't quit. Are you sure you want to go ahead? ",
                        onContinuePressed: () {
                          print('Hello');
                        });

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}