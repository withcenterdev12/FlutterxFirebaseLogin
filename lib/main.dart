import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mylogin/controllers/usercontroller.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'router.dart';
import 'package:provider/provider.dart';
import 'package:easy_design_system/easy_design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserController(),
      child: MaterialApp.router(
        theme: ComicThemeData.of(context),
        routerConfig: router,
        title: "My Login App",
      ),
    );
  }
}
