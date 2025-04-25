import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profilepage';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final name = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name != null ? 'Profile Page ${name.email}' : 'Not logged in',
        ),
      ),
    );
  }
}
