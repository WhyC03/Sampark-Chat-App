import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark_app/features/contacts_list/controller/contact_controller.dart';
import 'package:sampark_app/features/chat/userprofile/controller/user_profile_controller.dart';
import 'package:sampark_app/models/audio_call_model.dart';
import 'package:sampark_app/models/chat_model.dart';
import 'package:sampark_app/models/chat_room_model.dart';
import 'package:sampark_app/models/user_model.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = Uuid();

  RxString selectedImagePath = ''.obs;
  ProfileController profileController = Get.put(ProfileController());
  ContactController contactController = Get.put(ContactController());

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUser;
    } else {
      return targetUser;
    }
  }

  UserModel getReciever(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return targetUser;
    } else {
      return currentUser;
    }
  }

  // Future<void> sendMessage(
  //     String targetUserId, String message, UserModel targetUser) async {
  //   isLoading.value = true;
  //   String chatId = uuid.v6();
  //   String roomId = getRoomId(targetUserId);
  //   DateTime timeStamp = DateTime.now();
  //   String currentTime = DateFormat('hh:mm a').format(timeStamp);
  //   var newChat = ChatModel(
  //     message: message,
  //     id: chatId,
  //     senderId: auth.currentUser!.uid,
  //     recieverId: targetUserId,
  //     senderName: controller.currentUser.value.name,
  //     timeStamp: DateTime.now().toString(),
  //   );
  //   var reciever = UserModel(
  //     id: controller.currentUser.value.id,
  //     name: controller.currentUser.value.name,
  //     profilePic: controller.currentUser.value.profilePic,
  //     email: controller.currentUser.value.email,
  //     about: controller.currentUser.value.about
  //   );
  //   var roomDetails = ChatRoomModel(
  //     id: roomId,
  //     lastMessage: message,
  //     lastMessageTimedstamp: currentTime,
  //     sender: controller.currentUser.value,
  //     reciever: targetUser,
  //     timeStamp: DateTime.now().toString(),
  //     unReadMessNo: 0,
  //   );
  //   try {
  //     await db.collection("chat").doc(roomId).set(
  //           roomDetails.toJson(),
  //         );
  //     await db
  //         .collection("chat")
  //         .doc(roomId)
  //         .collection("messages")
  //         .doc(chatId)
  //         .set(
  //           newChat.toJson(),
  //         );
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   isLoading.value = false;
  // }

  Future<void> sendMessage(
      String targetUserId, String message, UserModel targetUser) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);
    DateTime timeStamp = DateTime.now();
    String currentTime = DateFormat('hh:mm a').format(timeStamp);

    UserModel sender =
        getSender(profileController.currentUser.value, targetUser);
    UserModel reciever =
        getReciever(profileController.currentUser.value, targetUser);

    RxString imageUrl = ''.obs;

    if (selectedImagePath.value.isNotEmpty) {
      imageUrl.value =
          await profileController.uploaFileToFirebase(selectedImagePath.value);
    }

    var newChat = ChatModel(
      message: message,
      id: chatId,
      imageUrl: imageUrl.value,
      senderId: auth.currentUser!.uid,
      recieverId: targetUserId,
      senderName: profileController.currentUser.value.name,
      timeStamp: DateTime.now().toString(),
    );
    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTimedstamp: currentTime,
      sender: sender,
      reciever: reciever,
      timeStamp: DateTime.now().toString(),
      unReadMessNo: 0,
    );

    try {
      await db
          .collection("chat")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(
            newChat.toJson(),
          );
      selectedImagePath.value = '';
      await db.collection('chat').doc(roomId).set(
            roomDetails.toJson(),
          );
      await contactController.saveContact(targetUser);
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection('chat')
        .doc(roomId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => ChatModel.fromJson(
                doc.data(),
              ),
            )
            .toList());
  }

  Stream<UserModel> getStatus(String uid) {
    return db.collection('users').doc(uid).snapshots().map(
      (event) {
        return UserModel.fromJson(event.data()!);
      },
    );
  }

  Stream<List<CallModel>> getCalls() {
    return db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('calls')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => CallModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }
}
