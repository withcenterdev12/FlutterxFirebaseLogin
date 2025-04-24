import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:mylogin/screens/profile.dart';

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

  String? _loggedInEmail;

  @override
  void initState() {
    debugPrint("Initialize User $_loggedInEmail");

    super.initState();
  }

  @override
  void dispose() {
    debugPrint("Dispose User $_loggedInEmail");
    super.dispose();
  }

  Future<void> loginUser() async{
    try{
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        );

        setState((){
          _loggedInEmail = userCredential.user!.email;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Logged in as ${userCredential.user!.email}")),

        );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.toString()}")),
      );
    }
  }

  Future<void> logoutUser() async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged Out ${user.email}")));
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No User Logged in'))
      );
    }
    
  }

  void _checkCurrentUser(){
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      setState((){
      _loggedInEmail = user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [
      Text('Login'),
      TextField( controller: _emailController, keyboardType: TextInputType.emailAddress,),
      Text('Password'),
      TextField(controller: _passwordController, obscureText: true),
      ElevatedButton(onPressed: loginUser, child: Text('Login')),
      ElevatedButton(onPressed: logoutUser, child: Text('Logout')),
      ElevatedButton(onPressed: () {context.push(ProfilePage.routeName);}, child: Text('Profile'),),
      Text(
      _loggedInEmail != null ? 'Logged in as $_loggedInEmail' : 'No user currently logged in'
      )
    ],));
  }
}