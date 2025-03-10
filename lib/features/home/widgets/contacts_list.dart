import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/features/chat/screens/chat_screen.dart';
import 'package:sampark_app/features/contacts_list/controller/contact_controller.dart';
import 'package:sampark_app/features/home/widgets/chat_tile.dart';
import 'package:sampark_app/features/chat/userprofile/controller/user_profile_controller.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    return RefreshIndicator(
        child: Obx(
          () => contactController.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : contactController.chatRoomList.isEmpty
              ? Center(
                  child: Text("Start Chatting"),
                )
              : ListView(
                  children: contactController.chatRoomList
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            Get.to(
                              () => ChatScreen(
                                userModel: (e.reciever!.id ==
                                        profileController.currentUser.value.id
                                    ? e.sender
                                    : e.reciever)!,
                              ),
                            );
                          },
                          child: ChatTile(
                            imageUrl: (e.reciever!.id ==
                                        profileController.currentUser.value.id
                                    ? e.sender!.profilePic
                                    : e.reciever!.profilePic) ??
                                AssetsImage.defaultProfilePic,
                            name: (e.reciever!.id ==
                                        profileController.currentUser.value.id
                                    ? e.sender!.name
                                    : e.reciever!.name) ??
                                "User Name",
                            lastText: e.lastMessage ?? '',
                            lastTime: e.lastMessageTimedstamp ?? '08:33 PM',
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        onRefresh: () {
          return contactController.getChatRoomList();
        });
  }
}
