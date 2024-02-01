import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> getAllRegisteredUsers() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> userList = [];

  // Get all keys in SharedPreferences
  Set<String> keys = prefs.getKeys();

  // Filter keys that represent user data (e.g., user_1, user_2)
  List<String> userKeys = keys.where((key) => key.startsWith('user_')).toList();

  // Retrieve user data for each key
  for (String key in userKeys) {
    Map<String, dynamic> userData = Map<String, dynamic>.from(
      prefs.getString(key) != null
          ? json.decode(prefs.getString(key)!)
          : {},
    );

    userList.add(userData);
  }

  return userList;
}
