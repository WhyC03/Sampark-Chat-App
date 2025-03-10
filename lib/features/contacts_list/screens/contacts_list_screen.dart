// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
// import 'package:sampark_app/features/chat/controller/chat_controller.dart';
import 'package:sampark_app/features/chat/screens/chat_screen.dart';
import 'package:sampark_app/features/contacts_list/controller/contact_controller.dart';
import 'package:sampark_app/features/contacts_list/widgets/contact_search.dart';
import 'package:sampark_app/features/contacts_list/widgets/new_contact_tile.dart';
import 'package:sampark_app/features/groups/widgets/new_group.dart';
import 'package:sampark_app/features/home/widgets/chat_tile.dart';
import 'package:sampark_app/features/chat/userprofile/controller/user_profile_controller.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController = Get.put(ContactController());
    // ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Contact",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                isSearchEnable.value = !isSearchEnable.value;
              },
              icon:
                  isSearchEnable.value ? Icon(Icons.close) : Icon(Icons.search),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Obx(
              () => isSearchEnable.value ? ContactSearch() : SizedBox(),
            ),
            SizedBox(height: 10),
            NewContactTile(
              btnName: 'New Contact',
              icon: Icons.person_add,
              onTap: () {},
            ),
            SizedBox(height: 10),
            NewContactTile(
              btnName: "New Group",
              icon: Icons.group_add,
              onTap: () {
                Get.to(() => NewGroup());
                
              },
            ),
            SizedBox(height: 10),
            Text("Contacts on Sampark"),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children: contactController.userList
                    .map(
                      (e) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.to(
                            () => ChatScreen(
                              userModel: e,
                            ),
                          );
                        },
                        child: ChatTile(
                          imageUrl:
                              e.profilePic ?? AssetsImage.defaultProfilePic,
                          name: e.name ?? "User",
                          lastText: e.about ?? "Hey There!!",
                          lastTime: e.email ==
                                  profileController.currentUser.value.email
                              ? "You"
                              : " ",
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
