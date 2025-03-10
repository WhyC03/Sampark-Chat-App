import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/features/groups/controller/group_controller.dart';
import 'package:sampark_app/features/home/widgets/chat_tile.dart';
import 'package:sampark_app/features/chat/userprofile/controller/image_picker_controller.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    RxString nameController = ''.obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = ''.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Group Details",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: nameController.value.isEmpty
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (nameController.value.isEmpty) {
              Get.snackbar("Error", "Please Type Some group name");
            } else {
              groupController.createGroup(
                  nameController.value, imagePath.value);
            }
          },
          child: groupController.isLoading.value
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Icon(
                  Icons.done,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Obx(
                        () => InkWell(
                          onTap: () async {
                            imagePath.value = await imagePickerController
                                .pickImage(ImageSource.gallery);

                            log("Image picked");
                            log(imagePath.value);
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: imagePath.value == ''
                                ? Icon(
                                    Icons.group_add,
                                    size: 40,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      File(imagePath.value),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          nameController.value = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Group Name",
                          prefixIcon: Icon(Icons.group),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: groupController.groupMembers
                    .map(
                      (e) => ChatTile(
                          imageUrl:
                              e.profilePic ?? AssetsImage.defaultProfilePic,
                          name: e.name ?? "",
                          lastText: e.about ?? "",
                          lastTime: ""),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
