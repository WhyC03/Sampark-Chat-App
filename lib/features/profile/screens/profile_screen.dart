import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampark_app/features/auth/controller/auth_controller.dart';
import 'package:sampark_app/features/chat/userprofile/controller/image_picker_controller.dart';
import 'package:sampark_app/features/chat/userprofile/controller/user_profile_controller.dart';
import 'package:sampark_app/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController nameController =
        TextEditingController(text: profileController.currentUser.value.name);
    TextEditingController emailController =
        TextEditingController(text: profileController.currentUser.value.email);
    TextEditingController phoneController = TextEditingController(
        text: profileController.currentUser.value.phoneNumber);
    TextEditingController aboutController =
        TextEditingController(text: profileController.currentUser.value.about);
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Obx(
                      () => isEdit.value
                          ? InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                imagePath.value = await imagePickerController
                                    .pickImage(ImageSource.gallery);

                                log("Image picked");
                                log(imagePath.value);
                              },
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: imagePath.value == ""
                                    ? Icon(Icons.add)
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          File(imagePath.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            )
                          : Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: profileController
                                              .currentUser.value.profilePic ==
                                          null ||
                                      profileController
                                              .currentUser.value.profilePic ==
                                          ""
                                  ? Icon(Icons.image)
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child:
                                          // Image.network(
                                          //   profileController
                                          //       .currentUser.value.profilePic!,
                                          //   fit: BoxFit.cover,
                                          // ),
                                          CachedNetworkImage(
                                        imageUrl: profileController
                                            .currentUser.value.profilePic!,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => TextField(
                      controller: nameController,
                      enabled: isEdit.value,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: isEdit.value,
                          labelText: "Name",
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "Name"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => TextField(
                      controller: aboutController,
                      enabled: isEdit.value,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: isEdit.value,
                        labelText: "About",
                        prefixIcon: Icon(Icons.info_outline),
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    enabled: false,
                    decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        filled: false,
                        labelText: "Email Id",
                        prefixIcon: Icon(Icons.alternate_email_outlined),
                        hintText: "abc@example.com"),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => TextField(
                      controller: phoneController,
                      enabled: isEdit.value,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: isEdit.value,
                          labelText: "Phone Number",
                          prefixIcon: Icon(Icons.phone_outlined),
                          hintText: "90XXXXXXXX"),
                    ),
                  ),
                  SizedBox(height: 20),
                  profileController.isLoading.value
                      ? CircularProgressIndicator()
                      : Obx(
                          () => isEdit.value
                              ? SizedBox(
                                  width: 200,
                                  child: CustomButton(
                                    text: "Save",
                                    icon: Icons.save,
                                    onTap: () async {
                                      await profileController.updateProfile(
                                        imagePath.value,
                                        nameController.text,
                                        aboutController.text,
                                        phoneController.text,
                                      );
                                      isEdit.value = false;
                                    },
                                  ),
                                )
                              : SizedBox(
                                  width: 200,
                                  child: CustomButton(
                                    text: "Edit",
                                    icon: Icons.edit,
                                    onTap: () {
                                      isEdit.value = true;
                                    },
                                  ),
                                ),
                        ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
