// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, depend_on_referenced_packages, use_key_in_widget_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() async {
    // Clear all registered users
    await clearAllRegisteredUsers();

    // Store username and password in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('password', _passwordController.text);

    // Show registration success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration Successful')),
    );

    // Navigate back to login page
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text('Registration Page')),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.lock_open,
                size: 100,
              ),
              SizedBox(height: 50),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _register,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to clear all registered users in SharedPreferences
Future<void> clearAllRegisteredUsers() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Set<String> keys = prefs.getKeys();
  List<String> userKeys = keys.where((key) => key.startsWith('user_')).toList();
  

  for (String key in userKeys) {
    prefs.remove(key);
  }
}
