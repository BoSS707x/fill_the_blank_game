// ignore_for_file: prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, camel_case_types, use_key_in_widget_constructors, prefer_collection_literals, deprecated_member_use

import 'dart:async';
import 'package:fill_the_blank_game/pages/end_page.dart';
import 'package:flutter/material.dart';

import 'timer_ended_page.dart';

class Level {
  String question;
  String answer;
  String imagePath;

  Level(
      {required this.question, required this.answer, required this.imagePath});
}

class FillTheBlankWidget extends StatefulWidget {
  @override
  _FillTheBlankWidgetState createState() => _FillTheBlankWidgetState();
}

class _FillTheBlankWidgetState extends State<FillTheBlankWidget> {
  int currentLevel = 0;
  int score = 0;
  int timeLeft = 9; // Time in seconds (3 minutes)
  Timer? timer;
  Set<String> pressedLetters = Set<String>();

  List<Level> levels = [
    Level(
      question: "The capital of France is ___",
      answer: "p",
      imagePath: "lib/images/cat.jpg",
    ),

    // Level(
    //     question: "The color of the sky is ___",
    //     answer: "blue",
    //     imagePath: "lib/images/dog.jpg",
    // ),
    // Level(
    //     question: "Shape with three angles ___",
    //     answer: "triangle",
    //     imagePath: "lib/images/cat.jpg",
    // ),
    // Add more levels here
  ];

  TextEditingController answerController = TextEditingController();
  String feedback = "";

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          t.cancel();
          // Navigate to EndPage when time runs out
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TimerEndedPage(score: score, timeLeft: 0),
            ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkAnswer() {
    String correctAnswer = levels[currentLevel].answer;
    if (answerController.text.toLowerCase() == correctAnswer) {
      setState(() {
        feedback = "Correct! 🎉";
        score += 10;
        if (currentLevel < levels.length - 1) {
          currentLevel++;
        } else {
          // If it's the last level, navigate to EndPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EndPage(
                score: score,
                timeLeft: timeLeft,
              ),
            ),
          );
        }
      });
    } else {
      setState(() {
        feedback = "Incorrect, try again!";
        if (timeLeft > 10) {
          timeLeft -= 10; // Reduce 10 seconds for wrong answer
        } else {
          timeLeft = 0; // Prevent negative time
        }
      });
    }
    answerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Fill the Blank Game Level ${currentLevel + 1}',
            ),
            Text(
              'Score: $score',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellowAccent, // Set the color to yellow
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Replace custom painters with Image.asset
                Image.asset(
                  levels[currentLevel]
                      .imagePath, // Replace with your image file path
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 5.0),
                Text(
                  levels[currentLevel].question,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 5.0),
                ElevatedButton(
                  onPressed: checkAnswer,
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 25),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  feedback,
                  style: TextStyle(
                    color: feedback.startsWith("Correct")
                        ? Colors.green
                        : Colors.red,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 6.0),
                buildAnswerCubes(),
                SizedBox(height: 3.0),
                buildKeyboard(),
                SizedBox(height: 2.0),
                Text(''),
              ],
            ),
          ),
          Positioned(
            bottom: 107,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Text(
                  'Time Left: ${timeLeft}s',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildKeyboard() {
    final String letters = currentLevel == 0
        ? 'supddafrhios'
        : (currentLevel == 1 ? 'kbealrhgufey' : 'ytsrtdianhglje');

    List<Widget> keyboardButtons = letters.split('').map((String letter) {
      return ElevatedButton(
        onPressed: () {
          answerController.text += letter;
          setState(() {});
        },
        child: Text(letter.toUpperCase()),
      );
    }).toList();

    // Add the delete button to the keyboard
    keyboardButtons.add(
      ElevatedButton(
        onPressed: () {
          if (answerController.text.isNotEmpty) {
            setState(() {
              answerController.text = answerController.text
                  .substring(0, answerController.text.length - 1);
            });
          }
        },
        child: Icon(Icons.backspace),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Wrap(
            spacing: 11.0,
            runSpacing: 6,
            children: keyboardButtons,
          ),
        ),
      ],
    );
  }

  Widget buildAnswerCubes() {
    List<Widget> cubes = [];
    for (int i = 0; i < answerController.text.length; i++) {
      cubes.add(Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            answerController.text[i].toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cubes,
    );
  }
}

class FillTheBlankGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fill the Blank Game',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: FillTheBlankWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(FillTheBlankGame());
}
