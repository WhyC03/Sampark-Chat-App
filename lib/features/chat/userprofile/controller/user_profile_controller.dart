import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sampark_app/models/user_model.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final store = FirebaseStorage.instance;
  RxBool isLoading = false.obs;

  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    await db.collection("users").doc(auth.currentUser!.uid).get().then(
          (value) => {
            currentUser.value = UserModel.fromJson(
              value.data()!,
            ),
          },
        );
  }

  Future<void> updateProfile(
    String? imageUrl,
    String? name,
    String? about,
    String? number,
  ) async {
    isLoading.value = true;
    try {
      if (imageUrl == "") {
        final updatedUser = UserModel(
          id: auth.currentUser!.uid,
          email: auth.currentUser!.email,
          name: name,
          about: about,
          phoneNumber: number,
        );
        await db.collection('users').doc(auth.currentUser!.uid).set(
              updatedUser.toJson(),
            );
      } else {
        final imageLink = await uploaFileToFirebase(imageUrl!);

        final updatedUser = UserModel(
          id: auth.currentUser!.uid,
          email: auth.currentUser!.email,
          name: name,
          about: about,
          profilePic: imageUrl == "" ? currentUser.value.profilePic : imageLink,
          phoneNumber: number,
        );
        await db.collection('users').doc(auth.currentUser!.uid).set(
              updatedUser.toJson(),
            );
      }

      await getUserDetails();
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }

  Future<String> uploaFileToFirebase(String imagePath) async {
    final path = "files/$imagePath";
    final file = File(imagePath);
    if (imagePath != "") {
      try {
        final ref = store.ref().child(path).putFile(file);
        final uploadTask = await ref.whenComplete(() {});
        final downloadImageUrl = await uploadTask.ref.getDownloadURL();
        log(downloadImageUrl.toString());
        return downloadImageUrl;
      } catch (e) {
        log(e.toString());
        return "";
      }
    }
    return "";
  }
}
