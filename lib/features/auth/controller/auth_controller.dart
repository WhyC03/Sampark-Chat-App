import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sampark_app/models/user_model.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  //Login Function
  Future<void> signIn(String email, String password) async {
    isLoading.value == true;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed('/home-screen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log("No User found for that email!");
      } else if (e.code == "wrong-password") {
        log("Wrong Password provided");
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading.value == false;
  }

  Future<void> signUp(String email, String password, String name) async {
    isLoading.value == true;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await initUser(email, name);
      log("Account Created");
      log(email);
      log(auth.currentUser!.uid);
      log(name);
      Get.offAllNamed('/home-screen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log("The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        log("User with this email exist!!");
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading.value == false;
  }

  Future<void> signOut() async {
    await auth.signOut();
    Get.offAllNamed('/auth-screen');
  }

  Future<void> initUser(String email, String name) async {
    var newUser = UserModel(
      email: email,
      name: name,
      id: auth.currentUser!.uid,
    );

    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set(newUser.toJson());
    } catch (e) {
      log(e.toString());
    }
  }
}
