import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    super.onInit();
    splashHandle();
  }

  void splashHandle() async {
    await Future.delayed(
      Duration(seconds: 1, milliseconds: 500),
    );
    if (auth.currentUser == null) {
      Get.offAllNamed('/welcome-screen');
    } else {
      Get.offAllNamed('/home-screen');
      log(auth.currentUser!.email.toString());
    }
  }
}
