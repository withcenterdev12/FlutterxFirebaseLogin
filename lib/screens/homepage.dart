import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylogin/screens/loginpage.dart';
import 'package:mylogin/screens/register.dart';
import 'package:mylogin/screens/user.listener.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          children: [
            // UserTest(
            //   builder: (data) {
            //     return Text(data.toString());
            //   },
            // ),
            ElevatedButton(
              onPressed: () {
                context.push(LoginPage.routeName);
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(RegisterPage.routeName);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
