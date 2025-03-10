import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/colors.dart';
import 'package:sampark_app/features/auth/widgets/login_form.dart';
import 'package:sampark_app/features/auth/widgets/signup_form.dart';

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    isLogin.value = true;
                  },
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2.5,
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: isLogin.value
                              ? Theme.of(context).textTheme.bodyLarge
                              : Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: 2),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: isLogin.value ? 120 : 0,
                          height: 3,
                          decoration: BoxDecoration(
                            color: dSecondaryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    isLogin.value = false;
                  },
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2.5,
                    child: Column(
                      children: [
                        Text(
                          "SignUp",
                          style: isLogin.value
                              ? Theme.of(context).textTheme.labelLarge
                              : Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 2),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: isLogin.value ? 0 : 120,
                          height: 3,
                          decoration: BoxDecoration(
                            color: dSecondaryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Obx(
            () => isLogin.value ? LoginForm() : SignUpForm(),
          ),
        ],
      ),
    );
  }
}
