import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_router/go_router.dart';
import 'package:mylogin/screens/profile.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/loginpage';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('This is the Login Page')),
      body: LoginDetails(),
    );
  }
}

class LoginDetails extends StatefulWidget {
  const LoginDetails({super.key});

  @override
  State<LoginDetails> createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<LoginDetails> {
  // Gets the email and password, then gives it to the controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to change online presence when logged in or logged out
  // Using onDisconnect, the status will also be changed on disconnection

  void setupOnlinePresence(User user) {
    // Gets the user status from the RTDB
    final statusRef = FirebaseDatabase.instance.ref("users/${user.uid}/status");
    // Gets the connected users using a special path .info/connected
    final connectedRef = FirebaseDatabase.instance.ref(".info/connected");

    // Listens to changes in the .info/connected
    connectedRef.onValue.listen((event) {
      // takes the value as bool, can be null and if null, pretend it's false (??)
      final connected = event.snapshot.value as bool? ?? false;

      // If connected, it will be offline on disconnect
      // The status will be set to online
      if (connected) {
        statusRef.onDisconnect().set("offline");
        statusRef.set("online");
      }
    });
  }

  // Logs in the user using Firebase's signInWithEmailAndPassword

  Future<void> loginUser() async {
    final auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;

    // Checks if someone is currently logged in
    // If none, login the user with email and password
    // else, simply return a scaffold messenger that says someone is currently logged in
    if (currentUser == null) {
      try {
        final userCredential = await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        // The user calls setupOnlinePresence for the user
        final user = userCredential.user!;
        setupOnlinePresence(user);

        // Declares variables to register the email of not yet on the RTDB but on Auth
        final userRef = FirebaseDatabase.instance.ref("users/${user.uid}");
        final snapshot = await userRef.get();

        if (!snapshot.exists) {
          await userRef.set({"email": user.email, "status": "online"});
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Logged in as ${userCredential.user!.email}")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${e.toString()}")),
        );
      }

      _emailController.clear();
      _passwordController.clear();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('User already logged in!')));
    }

    setState(() {
      _currentUser = FirebaseAuth.instance.currentUser;
    });
  }

  Future<void> logoutUser() async {
    // Logs out user and then sets offline on RTDB
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseDatabase.instance
          .ref("users/${user.uid}/status")
          .set("offline");

      await FirebaseAuth.instance.signOut();
      setState(() {
        _currentUser = null;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Logged Out ${user.email}")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No User Logged in')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Center(
      child: Column(
        children: [
          Text('Login'),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          Text('Password'),
          TextField(controller: _passwordController, obscureText: true),
          ElevatedButton(
            onPressed: user == null ? loginUser : null,
            child: Text('Login'),
          ),
          ElevatedButton(
            onPressed: user != null ? logoutUser : null,
            child: Text('Logout'),
          ),
          ElevatedButton(
            onPressed:
                user != null
                    ? () {
                      context.push(ProfilePage.routeName);
                    }
                    : null,
            child: Text('Profile'),
          ),
          Text(
            user != null
                ? 'Logged in as: ${user.email}'
                : 'No user is logged in',
          ),
        ],
      ),
    );
  }
}
