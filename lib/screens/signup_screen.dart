import 'package:chat_app_firebase/services/auth/auth_service.dart';
import 'package:chat_app_firebase/utils/components/buttons.dart';
import 'package:chat_app_firebase/utils/components/textfield.dart';
import 'package:chat_app_firebase/utils/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmpasswordController =
      TextEditingController();

  void signup(BuildContext context) async {
    final authService = AuthService();
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmpasswordController.text.isNotEmpty) {
      if (_passwordController.text == _confirmpasswordController.text) {
        try {
          await authService.signupWithEmailandPassword(context,
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
          if (!context.mounted) return;
          Navigator.pushReplacementNamed(context, '/signin');
          QuickAlert.show(
              context: context,
              type: QuickAlertType.info,
              text: "Signup Successfully");
          // print(_emailController.text);
        } catch (e) {
          QuickAlert.show(
              context: context, type: QuickAlertType.error, text: e.toString());
        }
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            text: "Password and Confirm Password must be same");
      }
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: "Please fill all field");
    }
  }

  @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _confirmpasswordController.dispose();
  //   // TODO: implement dispose
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
            height: 10,
          ),
          MytextField(
            hintext: "Confirm Password..",
            ishide: true,
            controller: _confirmpasswordController,
          ),
          const SizedBox(
            height: 25,
          ),
          // login button
          MyButton(
            text: "Signup",
            onTap: () {
              signup(context);
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
                "Already have an account ? ",
                style: TextStyle(
                    color: isDarkMode
                        ? Colors.white70
                        : Theme.of(context).primaryColor),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/signin',
                    (route) => false,
                  );
                },
                child: Text(
                  " Signin now",
                  selectionColor: Colors.black,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDarkMode? Colors.white70: Theme.of(context).colorScheme.primaryFixedDim),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
