// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class UserTest extends StatefulWidget {
//   const UserTest({super.key, required this.builder});

//   final Function(User?) builder;

//   @override
//   State<UserTest> createState() => _UserTestState();
// }

// class _UserTestState extends State<UserTest> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, snapshot) {
//         final data = snapshot.data;
//         return widget.builder(data);
//       },
//     );
//   }
// }
