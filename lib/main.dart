import 'package:chat_app_firebase/screens/blocked_user_screen.dart';
import 'package:chat_app_firebase/services/auth/auth_gate.dart';
import 'package:chat_app_firebase/firebase_options.dart';
import 'package:chat_app_firebase/screens/home_screen.dart';
import 'package:chat_app_firebase/screens/setting_screen.dart';
import 'package:chat_app_firebase/screens/signin_screen.dart';
import 'package:chat_app_firebase/screens/signup_screen.dart';
import 'package:chat_app_firebase/utils/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthGate(),
          '/signup': (context) => const SignupScreen(),
          '/signin': (context) => const SigninScreen(),
          '/home': (context) => HomeScreen(),
          '/settings': (context) => const SettingScreen(),
          // '/chat': (context) => const ChatScreen(recieverEmail: "")
          '/blocked': (context) => BlockedUserScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Provider.of<ThemeProvider>(context).themeData);
  }
}
