import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sampark_app/features/home/screens/home_screen.dart';
import 'package:sampark_app/features/chat/userprofile/controller/user_profile_controller.dart';
import 'package:sampark_app/models/chat_model.dart';
import 'package:sampark_app/models/group_model.dart';
import 'package:sampark_app/models/user_model.dart';
import 'package:sampark_app/widgets/custom_message.dart';
import 'package:uuid/uuid.dart';

class GroupController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxList<UserModel> groupMembers = <UserModel>[].obs;

  RxString selectedImagePath = ''.obs;
  RxBool isLoading = false.obs;
  RxList<GroupModel> groupList = <GroupModel>[].obs;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());

  @override
  void onInit() {
    super.onInit();
    getGroups();
  }

  void selectMembers(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true;
    String groupId = uuid.v6();

    groupMembers.add(
      UserModel(
        id: auth.currentUser!.uid,
        name: profileController.currentUser.value.name,
        profilePic: profileController.currentUser.value.profilePic,
        email: profileController.currentUser.value.email,
        role: "Admin",
      ),
    );
    try {
      String imageUrl = await profileController.uploaFileToFirebase(imagePath);
      // var newGroup = GroupModel();

      await db.collection('groups').doc(groupId).set({
        "id": groupId,
        "name": groupName,
        "profileUrl": imageUrl,
        "members": groupMembers.map((e) => e.toJson()).toList(),
        "createdAt": DateTime.now().toString(),
        "createdBy": auth.currentUser!.uid,
        "timeStamp": DateTime.now().toString(),
      });
      successMessage("Group Created");
      Get.off(() => HomeScreen());
      isLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getGroups() async {
    try {
      isLoading.value = true;
      final snapshot = await db.collection('groups').get();

      groupList.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return GroupModel.fromJson(data);
      }).toList();

      isLoading.value = false;
      log("Group Function being called");
    } catch (e) {
      log('Error fetching groups: $e');
    }
  }

  Future<void> sendGroupMessage(
      String message, String groupId, String imagePath) async {
    isLoading.value = true;
    var chatId = uuid.v6();

    String imageUrl =
        await profileController.uploaFileToFirebase(selectedImagePath.value);
    var newChat = ChatModel(
      message: message,
      id: chatId,
      imageUrl: imageUrl,
      senderId: auth.currentUser!.uid,
      senderName: profileController.currentUser.value.name,
      timeStamp: DateTime.now().toString(),
    );
    await db
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .doc(chatId)
        .set(
          newChat.toJson(),
        );
    selectedImagePath.value = '';
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getGroupMessages(String groupId) {
    return db
        .collection('groups')
        .doc(groupId)
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

  Future<void> addMemberToGroup(String groupId, UserModel user) async {
    isLoading.value = true;
    await db.collection('groups').doc(groupId).update(
      {
        'members': FieldValue.arrayUnion([ user.toJson()]),
      },
    );
    getGroups();
    isLoading.value = false;
  }
}
