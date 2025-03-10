import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sampark_app/models/chat_room_model.dart';
import 'package:sampark_app/models/user_model.dart';

class ContactController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserList();
    await getChatRoomList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      userList.clear();
      await db.collection("users").get().then(
            (val) => {
              userList.value = val.docs
                  .map(
                    (e) => UserModel.fromJson(
                      e.data(),
                    ),
                  )
                  .toList(),
            },
          );
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }

  Future<void> getChatRoomList() async {
    List<ChatRoomModel> tempChatRoom = [];
    await db
        .collection('chat')
        .orderBy("timeStamp", descending: true)
        .get()
        .then(
      (value) {
        tempChatRoom = value.docs
            .map(
              (e) => ChatRoomModel.fromJson(e.data()),
            )
            .toList();
      },
    );
    chatRoomList.value = tempChatRoom
        .where(
          (e) => e.id!.contains(
            auth.currentUser!.uid,
          ),
        )
        .toList();
    // log(chatRoomList.toString());
    // log(ourChatRooms.toString());
  }

  Future<void> saveContact(UserModel user) async {
    try {
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('contacts')
          .doc(user.id)
          .set(
            user.toJson(),
          );
    } catch (e) {
      if (kDebugMode) {
        log("Error while saving contact");
        log(e.toString());
      }
    }
  }

  Stream<List<UserModel>> getContacts() {
    return db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('contacts')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => UserModel.fromJson(
                doc.data(),
              ),
            )
            .toList());
  }
}
