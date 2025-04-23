import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/loginpage';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('This is the Login Page')
      ),
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> loginUser() async{
    try{
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Logged in as ${userCredential.user!.email}")),

        );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [
      Text('Login'),
      TextField( controller: _emailController, keyboardType: TextInputType.emailAddress,),
      Text('Password'),
      TextField(controller: _passwordController, obscureText: true),
      ElevatedButton(onPressed: loginUser, child: Text('Login'))
    ],));
  }
}