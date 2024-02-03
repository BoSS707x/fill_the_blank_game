// settings_page.dart
import 'package:fill_the_blank_game/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {

    void quitApp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Change Timer'),
              onTap: () async {
                int? newTimerDuration = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TimerDialog();
                  },
                );

                if (newTimerDuration != null) {
                  // Update the timer duration in SharedPreferences
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('timerDuration', newTimerDuration);
                }
              },
            ),
            ListTile(
              title: Text('Go Back to Home'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ),
                // Navigate back to the home page

            ),
            ListTile(
              title: Text('Quit Game'),
              onTap: quitApp,
            ),
            // ... other settings
          ],
        ),
      ),
    );
  }
}

class TimerDialog extends StatefulWidget {
  @override
  _TimerDialogState createState() => _TimerDialogState();
}

class _TimerDialogState extends State<TimerDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '180');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change Timer Duration'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Enter Timer Duration (seconds)'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            int? timerDuration = int.tryParse(_controller.text);
            if (timerDuration != null && timerDuration > 0) {
              Navigator.pop(context, timerDuration);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid timer duration. Please enter a positive number.'),
                ),
              );
            }
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
