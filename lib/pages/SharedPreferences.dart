import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearAllRegisteredUsers() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get all keys in SharedPreferences
  Set<String> keys = prefs.getKeys();

  // Filter keys that represent user data (e.g., user_1, user_2)
  List<String> userKeys = keys.where((key) => key.startsWith('user_')).toList();

  // Remove user data for each key
  for (String key in userKeys) {
    print('Removing user data for key: $key');
    prefs.remove(key);
  }

  print('All registered users cleared.');
}

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

// Example usage:
// Uncomment the line below to clear all registered users
// await clearAllRegisteredUsers();

// Example usage to get all registered users after clearing
// List<Map<String, dynamic>> users = await getAllRegisteredUsers();
// print('Remaining users after clearing: $users');
