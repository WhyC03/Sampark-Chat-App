import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/colors.dart';
import 'package:sampark_app/widgets/image_picker_bottom_sheet.dart';
import 'package:sampark_app/features/groups/controller/group_controller.dart';
import 'package:sampark_app/features/chat/userprofile/controller/image_picker_controller.dart';
import 'package:sampark_app/models/group_model.dart';

class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupTypeMessage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    RxString message = ''.obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    GroupController groupController = Get.put(GroupController());
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          SizedBox(
            child: Icon(
              Icons.emoji_emotions,
              color: dOnContainerColor,
              size: 30,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
              },
              controller: messageController,
              decoration: InputDecoration(
                filled: false,
                hintText: "Type Message....",
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(width: 10),
          Obx(
            () => groupController.selectedImagePath.value == ""
                ? InkWell(
                    onTap: () {
                      imagePickerBottomSheet(
                          context, groupController.selectedImagePath, imagePickerController);
                    },
                    child: Icon(
                      Icons.photo,
                      color: dOnContainerColor,
                      size: 30,
                    ),
                  )
                : SizedBox(),
          ),
          SizedBox(width: 10),
          Obx(
            () => InkWell(
              onTap: () {
                if (messageController.text.isNotEmpty ||
                    groupController.selectedImagePath.value.isNotEmpty) {
                  groupController.sendGroupMessage(
                      messageController.text, groupModel.id!, '');
                  messageController.clear();
                  message.value == '';
                }
              },
              child: groupController.isLoading.value
                  ? CircularProgressIndicator()
                  : SizedBox(
                      child: Icon(
                        message.value != "" ||
                                groupController.selectedImagePath.value != ''
                            ? Icons.send_rounded
                            : Icons.mic,
                        color: dOnContainerColor,
                        size: 30,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
