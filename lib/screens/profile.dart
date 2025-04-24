import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profilepage';
  const ProfilePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final name = FirebaseAuth.instance.currentUser;
    return Scaffold(appBar: AppBar(title: Text('Profile Page $name.email'),),);
  }
}