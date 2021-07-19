import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/Questions.dart';
import 'package:quiz_app/screens/score/score_screen.dart';

// we use get package for our state management
class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // let's animated our progress bar
  AnimationController _animationController;

  Animation _animation;
  Animation get animation => _animation;

  PageController _pageController;
  PageController get pageController => _pageController;

  List<Question> _questions = sample_data
      .map((question) => Question(
            id: question["id"],
            question: question["question"],
            options: question["options"],
            answer: question["answer_index"],
          ))
      .toList();

  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int _correctAnswerIndex;
  int get correctAnswerIndex => _correctAnswerIndex;

  int _selectedAnswerIndex;
  int get selectedAnswerIndex => _selectedAnswerIndex;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _correctAnswerCount = 0;
  int get correctAnswerCount => _correctAnswerCount;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        // update likes setState
        update();
      });

    // start animation
    _animationController.forward().whenComplete(() => nextQuestion());

    _pageController = PageController();

    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    _pageController.dispose();
    super.onClose();
  }

  void checkAnswer(Question question, int selectedIndex) {
    if (!_isAnswered) {
      _isAnswered = true;
      _correctAnswerIndex = question.answer;
      _selectedAnswerIndex = selectedIndex;

      if (_correctAnswerIndex == _selectedAnswerIndex) {
        _correctAnswerCount++;
      }

      _animationController.stop();
      update();

      // once user select an answer after 3s, it will go to the next qn
      Future.delayed(Duration(seconds: 2), () {
        nextQuestion();
      });
    }
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // reset animation timer
      _animationController.reset();
      _animationController.forward().whenComplete(() => nextQuestion());
    } else {
      Get.to(() => ScoreScreen());
    }
  }

  void updateQuestionNumber(int index) {
    _questionNumber.value = index + 1;
  }
}
