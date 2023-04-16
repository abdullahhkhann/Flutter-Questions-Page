import 'package:flutter/material.dart';
import 'dart:ffi' as prefix;

import 'package:alan_voice/alan_voice.dart';

import '../../AR_array_widget.dart';
import '../../ide_page.dart';
import 'array_answer_page.dart';

class ArrayQuestions extends StatefulWidget {
  const ArrayQuestions({super.key});

  @override
  State<ArrayQuestions> createState() => ArrayQuestionsState();
}

class ArrayQuestionsState extends State<ArrayQuestions> {
  @override
  List<Icon> _scoreTracker = [];

  //import the libraries !!!!!!!!

  ArrayQuestionsState() {
    AlanVoice.addButton(
        "19e80bfa8da2b588aed745dfcb35941d2e956eca572e1d8b807a3e2338fdd0dc/prod",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    //////////////CALLS _handleCommand FUNCTION BELOW THAT HANDLES ALL THE VOICE COMMANDS USING A SWITCH STATEMENT/////////////
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));

    /*if (AlanVoice.getWakewordEnabled() == true) {
      AlanVoice.playText("Hi, I am Alan. Nice to meet you. You may proceed to select an answer");
    }*/

    /*void _checkWakeWordEnabled() async {
      if (AlanVoice.getWakewordEnabled() as bool == true) {
        AlanVoice.playText(
            "Hi, I am Alan. Nice to meet you. You may proceed to select an answer");
      }
    }
    _checkWakeWordEnabled();*/
  }

  _handleCommand(Map<String, dynamic> command) {
    //////////////////////////////All voice scripts and commands are written in AlanAI project online///////////////

    switch (command["command"]) {

      /////////////////////////////////////GOES TO PREVIOUS PAGE WHEN USER SAYS "BACK"//////////////////////////////////////
      case "back":
        Navigator.pop(context);
        break;

      case "next_question":
        if (!selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "Please select an answer before proceeding to the next question!")));
          return;
        }
        _nextQuestion();
        break;

      case "retry_quiz":
        _restartQuiz();
        break;

      //////////////////////////////////////CASE IF USER SAYS CORRECT ANSWER FOR Q1//////////////////////////////////////////////
      case "q1_correct":
        if (quizEnd && selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer and the quiz has ended. Please retry!")));
          return;
        } else if (selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer, please proceed to the next quesetion!")));
          return;
        }
        _questionAnswered(true);
        break;

      //////////////////////////////////////CASE IF USER SAYS WRONG ANSWER FOR Q1//////////////////////////////////////////////
      case "q1_wrong":
        if (quizEnd && selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer and the quiz has ended. Please retry!")));
          return;
        } else if (selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer, please proceed to the next quesetion!")));
          return;
        }
        _questionAnswered(false);
        break;

      case "q2_correct":
        if (quizEnd && selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer and the quiz has ended. Please retry!")));
          return;
        } else if (selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer, please proceed to the next quesetion!")));
          return;
        }
        _questionAnswered(true);
        break;

      case "q2_wrong":
        if (quizEnd && selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer and the quiz has ended. Please retry!")));
          return;
        } else if (selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer, please proceed to the next quesetion!")));
          return;
        }
        _questionAnswered(false);
        break;

      case "q3_correct":
        if (quizEnd && selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer and the quiz has ended. Please retry!")));
          return;
        } else if (selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer, please proceed to the next quesetion!")));
          return;
        }
        _questionAnswered(true);
        break;

      case "q3_wrong":
        if (quizEnd && selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer and the quiz has ended. Please retry!")));
          return;
        } else if (selectedAnswer) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You have already selected an answer, please proceed to the next quesetion!")));
          return;
        }
        _questionAnswered(false);
        break;

      case "open_ide":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Idepage()));
        break;

      case "open_AR":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ARArrayQ()));
        break;

      default:
        debugPrint("Unknown Command");
    }
  }

  int _questionIndex = 0;
  int _totalScore = 0;
  bool selectedAnswer = false;
  bool quizEnd = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      selectedAnswer = true;

      if (answerScore) {
        _totalScore++;
      }
      _scoreTracker.add(answerScore
          ? const Icon(Icons.check_circle_outline,
              color: Colors.green, size: 40.0)
          : const Icon(Icons.cancel_outlined,
              color: Color.fromARGB(255, 242, 70, 58), size: 40.0));

      if (_questionIndex + 1 == _questions.length) {
        quizEnd = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      selectedAnswer = false;
    });

    if (_questionIndex >= _questions.length) {
      _restartQuiz();
    }
  }

  ///////////////////////////WHEN THE USER RETRIES THE QUIZ, THIS FUNCTION IS CALLED AND RESETS THE QUIZ///////////////////////
  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      quizEnd = false;
      selectedAnswer = false;
    });
  }

  /////////////////////////////////ONCE THE QUIZ ENDS, THIS FUNCTIONS IS CALLED AND DISPLAYS THE SCORE/////////////////////////
  Widget quizEndReturn() {
    if (quizEnd) {
      return Container(
        height: 230.0,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 65.0, vertical: 40.0),
        color: null,
        child: Center(
          child: Column(
            children: [
              Container(
                child: Text(
                  _totalScore >= 2
                      ? "Great Job!! You got $_totalScore/3\n You Passed,\n Congratulations!"
                      : "Try Again!\n Unfortunately you got $_totalScore/3, which is not satisfactory :/",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _totalScore >= 2 ? Colors.green : Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const Idepage();
                        },
                      ),
                    );
                  },
                  // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                  style: ElevatedButton.styleFrom(
                      elevation: 10.0,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  child: const Text('Open IDE'),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text('<Decode/>'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                //SPACE BETWEEN THE TOP APPBAR AND THE QUESTION BOX. IN THIS SPACE, THE ICONS ARE DISPLAYED FROM _scoreTracker LIST//
                if (_scoreTracker.isEmpty) const SizedBox(height: 40.0),
                if (_scoreTracker.isNotEmpty) ..._scoreTracker
              ],
            ),

            //////////////////////////////////////////////CONTAINER WHERE QUESTIONS ARE DISPLAYED///////////////////////////////////
            Container(
              width: double.infinity,
              height: 130.0,
              margin:
                  const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0, color: Color.fromARGB(255, 165, 55, 212)),
                ),
              ),
            ),

            ////////////////////ACCESSES THE _questions CONSTANT VARIABLE'S INFROMATION AT THE END OF THE CODE//////////////////////
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map(
              // Answer() function is from 'answer.dart' and must have answerText, answercolor, answerTap as mentioned in that file
              (answer) => Answer(

                  //GETS THE ANSWERS FROM _questions AND STORES IN answerText
                  answerText: answer['answer'] as String,

                  /*
                  CHECKS IF ANSWER IS TRUE OR FALSE AND STORES IN answerColor IF AN ANSWER IS SELECTED.
                  IF NO ANSWER IS SELECTED, THE OPTIONS REMAIN GRAY COLOR
                  */
                  answerColor: selectedAnswer
                      ? answer['score'] as bool
                          ? Colors.lightGreen
                          : Colors.redAccent
                      : const Color.fromARGB(255, 209, 207, 207),

                  //answerTap FUNCTION RUNS THIS CODE
                  answerTap: () {
                    if (quizEnd && selectedAnswer) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "You have already selected an answer and the quiz has ended. Please retry!")));
                      return;
                    } else if (selectedAnswer) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "You have already selected an answer, please proceed to the next quesetion!")));
                      return;
                    }

                    /*
                    RUNS _questionAnswered FUNCTION AND WILL TAKE SELECTED ANSWER AS THE PARAMETER(TRUE OR FALSE)
                    THIS RUNS ACCORDING TO IF QUESTION THAT WAS SELECTED, CORRECT OR WRONG
                    */
                    _questionAnswered(answer['score'] as bool);
                  }),
            ),

            const SizedBox(height: 15.0),

            //////////////////////////////////////////////NEXT QUESTION BUTTON/////////////////////////////////////////////////
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(15.0, 35.0),
                ),
                onPressed: () {
                  if (!selectedAnswer) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Please select an answer before proceeding to the next question!")));
                    return;
                  }
                  _nextQuestion();
                },

                //IF THE QUIZ HAS ENDED, SHOW RETRY BUTTON, OTHERWISE KEEP NEXT QUESTION BUTTON
                child: Text(quizEnd ? 'Retry' : 'Next Question')),

            //THIS FUNCTION IS CALLED TO DISPLAY THE SCORE MESSAGE ONCE QUIZ IS OVER
            quizEndReturn()
          ],
        ),
      ),

//dont touch this :)
      /*body: Container(
          child: Column(
            children: [
              RichText(
                  text: const TextSpan(
                      text: "\nArrays Quiz\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Idepage();
                      },
                    ),
                  );
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                child: const Text('Open IDE'),
              ),
            ],
          ),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              /*image: DecorationImage(
                image: AssetImage('images/bg_main.png'), fit: BoxFit.cover),*/
              ),
        )*/
    );
  }
}

/////////////////////QUESTIONS AND ASWERS STORED IN THIS CONSTANT VARIABLE _questions AS OBJECTS STORED IN AN ARRAY///////////////////
const _questions = [
  {
    'question': 'Which of the following imports the Array package',
    'answers': [
      {'answer': 'import java.util.*;', 'score': false},
      {'answer': 'import java.util.Array;', 'score': true},
      {'answer': 'import java.util.ArrayList;', 'score': false},
      {'answer': 'import java.util.Arrays;', 'score': false},
    ],
  },
  {
    'question': 'Create a new "numbers" Array of type int',
    'answers': [
      {'answer': 'int[] numbers = new int[];', 'score': true},
      {'answer': 'ArrayList<int> cars = new ArrayList();', 'score': false},
      {'answer': 'int[] cars = new int[];', 'score': false},
      {'answer': 'ArrayList cars = new ArrayList<String>();', 'score': false},
    ],
  },
  {
    'question':
        'Add a value (10) into the "numbers" array we created at index 0',
    'answers': [
      {'answer': 'numbers.add(10) = 0;', 'score': false},
      {'answer': 'numbers.add();', 'score': false},
      {'answer': 'add.numbers("10");', 'score': false},
      {'answer': 'numbers[0] = 10;', 'score': true},
    ],
  }
];
