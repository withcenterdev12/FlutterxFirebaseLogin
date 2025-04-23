import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UserController with ChangeNotifier {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('users');

  List<Map<String, dynamic>> _users = [];

  List<Map<String, dynamic>> get users => _users;

  /// CREATE: Register a new user
  Future<void> registerUser(String username, String password) async {
    final newUserRef = _dbRef.push();
    await newUserRef.set({
      'username': username,
      'password': password, // ❗️Note: Insecure for real apps
    });
  }

  /// READ: Fetch all users
  Future<void> fetchUsers() async {
    final snapshot = await _dbRef.get();
    final Map data = snapshot.value as Map? ?? {};

    _users = data.entries.map((e) {
      final key = e.key;
      final value = e.value as Map;
      return {
        'id': key,
        'username': value['username'],
        'password': value['password'],
      };
    }).toList();

    notifyListeners();
  }
}
