// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last, deprecated_member_use, sized_box_for_whitespace

import 'package:fill_the_blank_game/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimerEndedPage extends StatelessWidget {
  final String username;
  final int score;
  final int timeLeft;

  void quitApp() {
    SystemNavigator.pop();
  }

  TimerEndedPage({required this.username, required this.score, required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        //waleed  qtitle: Text('Game Over'),
        backgroundColor: Colors.grey[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Text(
              'You Ran Out Of Time!',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 150),
            Text(
              'User: $username',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Your Score: $score',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Time Left: $timeLeft seconds',
              style: TextStyle(fontSize: 24),
            ),
            
            SizedBox(height: 140),

            Container(
              width: 400,
              height: 75,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      'Restart',
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
