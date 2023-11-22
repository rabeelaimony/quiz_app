import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:intro_to_uitity/component/flushbar.dart';
import 'package:intro_to_uitity/model/question.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: QuizApp());
  }
}

List<QuestionModel> question = [
  QuestionModel(question: ' ماهي عاصمة سعودية ؟ ', time: 20, answers: [
    AnswerModel(answer: 'واشنطن', isCorrect: false),
    AnswerModel(answer: 'تركيا', isCorrect: false),
    AnswerModel(answer: 'جزائر', isCorrect: false),
    AnswerModel(answer: 'الرياض', isCorrect: true),
  ]),
  QuestionModel(question: 'ماهي عاصمة مصر؟', time: 20, answers: [
    AnswerModel(answer: 'لبنان', isCorrect: false),
    AnswerModel(answer: 'تونس', isCorrect: false),
    AnswerModel(answer: 'جزائر', isCorrect: false),
    AnswerModel(answer: 'قاهرة', isCorrect: true),
  ]),
  QuestionModel(question: 'ماهي عاصمة لبنان ؟', time: 20, answers: [
    AnswerModel(answer: 'سودان', isCorrect: false),
    AnswerModel(answer: 'عراق', isCorrect: false),
    AnswerModel(answer: 'قطيفة', isCorrect: false),
    AnswerModel(answer: 'بيروت', isCorrect: true),
  ]),
  QuestionModel(question: 'ماهي عاصمة سوريا ؟  ', time: 20, answers: [
    AnswerModel(answer: 'حمص ', isCorrect: false),
    AnswerModel(answer: 'حماة', isCorrect: false),
    AnswerModel(answer: 'دير الزور ', isCorrect: false),
    AnswerModel(answer: 'دمشق', isCorrect: true),
  ]),
];

int score = 0;

PageController controller = PageController();

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

num answerTime = 0;

class _QuizAppState extends State<QuizApp> with UitilityComponent {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        answerTime++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          itemCount: question.length,
          itemBuilder: (context, index) => Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFA32EC1),
              leading: Icon(Icons.arrow_back),
              actions: [Icon(Icons.settings_outlined)],
              elevation: 0,
            ),
            body: Column(children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    // width: 337,
                    height: 180,
                    decoration: ShapeDecoration(
                      color: Color(0xFFA32EC1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Stack(clipBehavior: Clip.none, children: [
                        Container(
                          width: 281,
                          height: 170,
                          child: Center(child: Text(question[index].question)),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0xFFFBEBFF),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 135,
                          left: 110,
                          child: Container(
                            width: 67,
                            height: 67,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: OvalBorder(),
                            ),
                            child: CircularProgressIndicator(
                              value: answerTime / question[index].time,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 147, 81, 163),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 240,
                height: 300,
                child: ListView.builder(
                  itemCount: question[index].answers.length,
                  itemBuilder: (context, ind) => Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFFA32EC1),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: CheckboxListTile(
                        title: Text(question[index].answers[ind].answer),
                        value: val,
                        onChanged: (value) {
                          checkoutAnswer(question[index].answers[ind].isCorrect,
                              context, question[index].time, answerTime);
                        },
                      ),
                    ),
                  ),
                ),
              )
              // const Checkbox(value: Text("TRTRT"), onChanged: SafeArea),
            ]),
          ),
        )));
  }
}

bool val = false;
