import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/features/auth/controller/auth_controller.dart';
import 'package:sampark_app/widgets/custom_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(
              Icons.alternate_email_outlined,
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(
              Icons.password,
            ),
          ),
        ),
        SizedBox(height: 50),
        Obx(
          () => authController.isLoading.value
              ? CircularProgressIndicator()
              : SizedBox(
                  width: 220,
                  child: Center(
                    child: CustomButton(
                      text: 'LOGIN',
                      icon: Icons.lock_open_rounded,
                      onTap: () {
                        authController.signIn(
                            emailController.text, passwordController.text);
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
