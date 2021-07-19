import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/welcome/welcome_screen.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          WebsafeSvg.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(
                flex: 3,
              ),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text(
                "${_qnController.correctAnswerCount * 10}/${_qnController.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(
                flex: 3,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: InkWell(
                  onTap: () {
                    // Get.to(() => WelcomeScreen());
                    Get.offAll(WelcomeScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(kDefaultPadding * 0.75),
                    decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      "Try Again",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.snackbar('Hi', 'i am a modern snackbar');
                    },
                    child: Text("Snackbar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.defaultDialog(
                          onConfirm: () => {Get.back()},
                          middleText: "Dialog made in 3 lines of code");
                    },
                    child: Text("Dialog"),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.bottomSheet(Container(
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                                leading: Icon(Icons.music_note),
                                title: Text('Music'),
                                onTap: () {}),
                            ListTile(
                              leading: Icon(Icons.videocam),
                              title: Text('Video'),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ));
                    },
                    child: Text("Bottom Sheet"),
                  ),
                ],
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
