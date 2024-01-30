// ignore_for_file: prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, camel_case_types, use_key_in_widget_constructors, prefer_collection_literals, deprecated_member_use

import 'dart:async';
import 'package:fill_the_blank_game/pages/end_page.dart';
import 'package:flutter/material.dart';

class Level {
  String question;
  String answer;
  CustomPainter painter;

  Level({required this.question, required this.answer, required this.painter});
}

class EiffelTowerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.3, size.height * 0.7, size.width * 0.4,
          size.height * 0.05),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.7),
      Offset(size.width * 0.45, size.height * 0.5),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.7),
      Offset(size.width * 0.55, size.height * 0.5),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.45, size.height * 0.5),
      Offset(size.width * 0.5, size.height * 0.3),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.55, size.height * 0.5),
      Offset(size.width * 0.5, size.height * 0.3),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.3),
      Offset(size.width * 0.5, 0),
      paint,
    );

    double middleHeight = size.height * 0.5;
    double step = size.height * 0.1;
    for (double i = middleHeight; i < size.height * 0.7; i += step) {
      canvas.drawLine(
        Offset(size.width * 0.3, i),
        Offset(size.width * 0.7, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class numbera extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    double scaleFactor = 1.4;

    var paint = Paint()
      ..color = Colors.brown
      ..strokeWidth =
          2 * scaleFactor 
      ..style = PaintingStyle.stroke;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.4),
        width: size.width * 0.4 * scaleFactor,
        height: size.height * 0.3 * scaleFactor,
      ),
      paint,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.6),
        width: size.width * 0.4 * scaleFactor,
        height: size.height * 0.3 * scaleFactor,
      ),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.2 * scaleFactor),
      Offset(size.width * 0.5, size.height * 0.8 * scaleFactor),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.3 * scaleFactor, size.height * 0.5),
      Offset(size.width * 0.7 * scaleFactor, size.height * 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GenericPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    var backgroundPaint = Paint()..color = Colors.blue;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    var bodyPaint = Paint()..color = Colors.brown;
    Rect bodyRect = Rect.fromPoints(
        Offset(size.width / 2 - 40, size.height / 2 + 20),
        Offset(size.width / 2 + 40, size.height / 2 + 100));
    canvas.drawRRect(
        RRect.fromRectAndRadius(bodyRect, Radius.circular(20)), bodyPaint);

    var headPaint = Paint()..color = Colors.brown;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2 - 40), 40.0, headPaint);

    var eyePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
        Offset(size.width / 2 - 20, size.height / 2 - 55), 10.0, eyePaint);
    canvas.drawCircle(
        Offset(size.width / 2 + 20, size.height / 2 - 55), 10.0, eyePaint);

    var nosePaint = Paint()..color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2 - 25), 5.0, nosePaint);

    var mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    var mouthPath = Path();
    mouthPath.moveTo(size.width / 2 - 10, size.height / 2 - 15);
    mouthPath.quadraticBezierTo(size.width / 2, size.height / 2,
        size.width / 2 + 10, size.height / 2 - 15);
    canvas.drawPath(mouthPath, mouthPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class FillTheBlankWidget extends StatefulWidget {
  @override
  _FillTheBlankWidgetState createState() => _FillTheBlankWidgetState();
}

class _FillTheBlankWidgetState extends State<FillTheBlankWidget> {
  int currentLevel = 0;
  int score = 0;
  int timeLeft = 180; 
  Timer? timer;
  Set<String> pressedLetters = Set<String>();

  List<Level> levels = [
    Level(
        question: "The capital of France is ___",
        answer: "paris",
        painter: EiffelTowerPainter()),

    Level(
        question: "The color of the sky is ___",
        answer: "blue",
        painter: GenericPainter()),
    Level(
        question: "shape with three angles ___",
        answer: "triangle",
        painter: numbera()),
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

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EndPage(score: score, timeLeft: timeLeft,),
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
            Text(
              'Fill the Blank Game Level ${currentLevel + 1}',
            ),
            Text(
              'Score: $score',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellowAccent, 
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
                CustomPaint(
                  size: Size(200, 200),
                  painter: levels[currentLevel].painter,
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

    keyboardButtons.add(
      ElevatedButton(
        onPressed: () {
          if (answerController.text.isNotEmpty) {
            setState(() {
              answerController.text =
                  answerController.text.substring(0, answerController.text.length - 1);
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
        primarySwatch:
            Colors.blueGrey, 
      ),
      home: FillTheBlankWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
