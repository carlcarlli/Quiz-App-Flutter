import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/question_controller.dart';

class Option extends StatelessWidget {
  const Option({
    Key key,
    this.text,
    this.index,
    this.press,
  }) : super(key: key);

  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          Color getTheRightColor() {
            if (qnController.isAnswered) {
              if (index == qnController.correctAnswerIndex) {
                return kGreenColor;
              } else if (index == qnController.selectedAnswerIndex &&
                  index != qnController.correctAnswerIndex) {
                return kRedColor;
              }
            }
            return kGrayColor;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == kGreenColor ? Icons.done : Icons.close;
          }

          return InkWell(
            onTap: press,
            child: Container(
                margin: EdgeInsets.only(top: kDefaultPadding),
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    border: Border.all(color: getTheRightColor()),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${index + 1}. $text",
                        style:
                            TextStyle(color: getTheRightColor(), fontSize: 16)),
                    Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                          color: getTheRightColor() == kGrayColor
                              ? Colors.transparent
                              : getTheRightColor(),
                          border: Border.all(color: getTheRightColor()),
                          borderRadius: BorderRadius.circular(50)),
                      child: getTheRightColor() == kGrayColor
                          ? null
                          : Icon(
                              getTheRightIcon(),
                              size: 16,
                            ),
                    ),
                  ],
                )),
          );
        });
  }
}
