import 'package:go_router/go_router.dart';
import 'screens/loginpage.dart';
import 'screens/homepage.dart';
import 'screens/register.dart';
import 'screens/profile.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: LoginPage.routeName,
      name: LoginPage.routeName,
      builder: (context, state) => const LoginPage(),

    ),
    GoRoute(
      path: RegisterPage.routeName,
      name: RegisterPage.routeName,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: ProfilePage.routeName,
      name: ProfilePage.routeName,
      builder:(context, state) => const ProfilePage(),),
  ]
);