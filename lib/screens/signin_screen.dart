import 'package:chat_app_firebase/services/auth/auth_service.dart';
import 'package:chat_app_firebase/utils/components/buttons.dart';
import 'package:chat_app_firebase/utils/components/textfield.dart';
import 'package:chat_app_firebase/utils/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void Signin() async {
    final authService = AuthService();
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      try {
        await authService.signinWithEmailandPassword(context,
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        // ignore: use_build_context_synchronously
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(
          context,
          '/home',
        );
      } catch (e) {
        QuickAlert.show(
            context: context, type: QuickAlertType.error, text: e.toString());
      }
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: "Fill All field");
    }
  }

  @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Icon(
            Icons.message_rounded,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 50,
          ),
          // welcome back message
          Text(
            "Welcome back you've been missed!",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 16),
          ),
          const SizedBox(
            height: 25,
          ),

          // email textfield
          MytextField(
            hintext: "Email..",
            ishide: false,
            controller: _emailController,
          ),
          const SizedBox(
            height: 10,
          ),
          MytextField(
            hintext: "Password..",
            ishide: true,
            controller: _passwordController,
          ),
          const SizedBox(
            height: 25,
          ),
          // Signin button
          MyButton(
            text: "Signin",
            color: isDarkMode ? Colors.white70 : null,
            onTap: () {
              Signin();
            },
          ),
          const SizedBox(
            height: 25,
          ),
          // register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member? ",
                style: TextStyle(
                    color: isDarkMode
                        ? Colors.white70
                        : Theme.of(context).primaryColor),
              ),
              InkWell(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/signup',
                  (route) => true,
                ),
                child: Text(
                  " Register now",
                  selectionColor: Colors.black,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primaryFixedDim),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
