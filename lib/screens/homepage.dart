import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylogin/screens/loginpage.dart';
import 'package:mylogin/screens/register.dart';
import 'package:mylogin/screens/user.listener.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylogin/screens/usersonline.dart';

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
            StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // Loading state (while connecting to the stream)
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                // Error state
                if (snapshot.hasError) {
                  return Text('Something went wrong!');
                }

                // If user is null => Not logged in
                final user = snapshot.data;
                if (user == null) {
                  return Text('Not logged in');
                }

                // If user is present
                return Text('Logged in as ${user.email}');
              },
            ),

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
            ElevatedButton(
              onPressed: () {
                context.push(OnlineUsers.routeName);
              },
              child: Text('Online Users'),
            ),
          ],
        ),
      ),
    );
  }
}
