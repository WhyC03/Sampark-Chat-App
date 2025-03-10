import 'package:flutter/material.dart';
import 'package:sampark_app/features/auth/widgets/auth_screen_body.dart';
import 'package:sampark_app/widgets/welcome_heading.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                WelcomeHeading(),
                SizedBox(height: 30),
                AuthScreenBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
