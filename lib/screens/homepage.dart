import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylogin/screens/loginpage.dart';
import 'package:mylogin/screens/register.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome'),)
    , body: Center(
      child: Column(
        children: [
          ElevatedButton(onPressed: () {context.push(LoginPage.routeName);}, child: Text('Login')),
          ElevatedButton(onPressed: () {context.push(RegisterPage.routeName);}, child: Text('Register'))
        ],
      ),
    ),
    );
  }
}