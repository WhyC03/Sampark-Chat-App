import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/features/auth/controller/auth_controller.dart';
import 'package:sampark_app/widgets/custom_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: "Name",
            prefixIcon: Icon(
              Icons.person,
            ),
          ),
        ),
        SizedBox(height: 30),
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
                      text: 'SIGNUP',
                      icon: Icons.lock_open_rounded,
                      onTap: () {
                        authController.signUp(
                            emailController.text, passwordController.text, nameController.text);
                        // Get.offAllNamed('/home-screen');
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
