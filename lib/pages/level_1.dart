// ignore_for_file: unused_local_variable, prefer_const_constructors, sort_child_properties_last, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_collection_literals, unnecessary_string_interpolations

import 'dart:async';
import 'package:fill_the_blank_game/pages/end_page.dart';
import 'package:fill_the_blank_game/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'timer_ended_page.dart';

class Level {
  String question;
  String answer;
  String imagePath;

  Level(
      {required this.question, required this.answer, required this.imagePath});
}

class FillTheBlankWidget extends StatefulWidget {
  final String registeredUsername;

  FillTheBlankWidget({required this.registeredUsername});

  @override
  _FillTheBlankWidgetState createState() => _FillTheBlankWidgetState();
}

class _FillTheBlankWidgetState extends State<FillTheBlankWidget> {
  int currentLevel = 0;
  int score = 0;
  int timeLeft = 180;
  Timer? timer;
  Set<String> pressedLetters = Set<String>();
  String currentUsername = "";

  List<Level> levels = [
    Level(
      question: "The coldest season is ______",
      answer: "winter",
      imagePath: "lib/images/winter.jpg",
    ),
    Level(
      question: "The opposite of fast is ____",
      answer: "slow",
      imagePath: "lib/images/slow.jpg",
    ),
    Level(
      question: "The color of the sky is ____",
      answer: "blue",
      imagePath: "lib/images/sky.jpg",
    ),
    Level(
      question: "The shape of a pizza is ______",
      answer: "circle",
      imagePath: "lib/images/pizza.jpg",
    ),
    Level(
      question: "Fish live in the ___",
      answer: "sea",
      imagePath: "lib/images/fish.jpg",
    ),
  ];

  TextEditingController answerController = TextEditingController();
  String feedback = "";

  @override
  void initState() {
    super.initState();
    getCurrentUsername();
    loadTimerDuration();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          t.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TimerEndedPage(score: score, timeLeft: 0, username: currentUsername,),
            ),
          );
        }
      });
    });
  }

  void loadTimerDuration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      timeLeft = prefs.getInt('timerDuration') ?? 180;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void getCurrentUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');

    setState(() {
      currentUsername = savedUsername ?? "";
    });
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EndPage(score: score, timeLeft: timeLeft, username: currentUsername,),
            ),
          );
        }
      });
    } else {
      setState(() {
        feedback = "Incorrect, try again!";
        if (timeLeft > 10) {
          timeLeft -= 10; 
        } else {
          timeLeft = 0; 
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
            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
            Row(
              children: [
                Text(
                  '$currentUsername',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Level ${currentLevel + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Score: $score',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  levels[currentLevel].imagePath,
                  width: 550,
                  height: 270,
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
                  backgroundColor: Colors.green,
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
                SizedBox(height: 12.0),
                buildKeyboard(),
                SizedBox(height: 5.0),
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
                    fontSize: 20,
                  ),
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
        ? 'rbnutwioahslce'
        : (currentLevel == 1 ? 'rbnutwioahslce' : 'rbnutwioahslce');

    List<Widget> keyboardButtons = letters.split('').map((String letter) {
      return ElevatedButton(
        onPressed: () {
          answerController.text += letter;
          setState(() {});
        },
        child: Text(
          letter.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        ),
      );
    }).toList();

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
          backgroundColor: Colors.blueGrey,
        ),

      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10,
            children: keyboardButtons,
          ),
        ),
      ],
    );
  }

  Widget buildAnswerCubes() {
    List<Widget> cubes = [];
    String answer = levels[currentLevel].answer;

    for (int i = 0; i < answer.length; i++) {
      cubes.add(Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            i < answerController.text.length
                ? answerController.text[i].toUpperCase()
                : '', 
            style: TextStyle(color: Colors.white, fontSize: 24,),
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
  final String registeredUsername;

  FillTheBlankGame({required this.registeredUsername});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fill the Blank Game',
      theme: ThemeData(
        backgroundColor: Colors.blueGrey,
      ),
      home: FillTheBlankWidget(registeredUsername: registeredUsername),
      debugShowCheckedModeBanner: false,
    );
  }
}
