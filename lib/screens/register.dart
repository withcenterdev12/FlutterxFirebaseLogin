import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/registrationpage';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Accesses the value on the fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Gets the text value of the email and password controller
    final email = _emailController.text;
    final password = _passwordController.text;

    // Check's if either field is empty
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email and Password cannot be empty')),
      );
      return;
    }

    // makes an instance that creates a new user with email and password
    // this is saved to Firebase Auth
    // This also automatically logs in the user
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get's the database instance
      final db = FirebaseDatabase.instance;
      final user = userCredential.user!;
      // Uses set and await to asynchronously register the new user to the
      // RTDB's users field
      await db.ref("users/${user.uid}").set({
        "email": user.email,
        "status": "online",
      });

      // Shows the user through the UI that the regustration is a success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User registered: ${userCredential.user!.email}'),
        ),
      );

      _emailController.clear();
      _passwordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Registration Failed')));
    }
  }

  // The UI for registration
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Username:'),
            TextField(controller: _emailController),
            const SizedBox(height: 16),
            const Text('Password:'),
            TextField(controller: _passwordController, obscureText: true),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _submit, child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}
