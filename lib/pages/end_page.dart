// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EndPage extends StatelessWidget {
  final int score;
  final int timeLeft;

  void quitApp() {
    SystemNavigator.pop(); 
  }

  EndPage({required this.score, required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 200),
            Text(
              'Your Score: $score',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10), 
            Text(
              'Time Left: $timeLeft seconds',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            Text(
              'Thank you for playing our game!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 150),
          Container(
              width: 400,
              height: 75,
              child: GestureDetector(
                onTap: quitApp,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      'Quit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
