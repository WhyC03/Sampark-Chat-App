import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/colors.dart';
import 'package:sampark_app/features/chat/controller/chat_controller.dart';
import 'package:sampark_app/widgets/image_picker_bottom_sheet.dart';
import 'package:sampark_app/features/chat/userprofile/controller/image_picker_controller.dart';
import 'package:sampark_app/models/user_model.dart';

class TypingSpace extends StatelessWidget {
  final UserModel userModel;
  const TypingSpace({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString message = ''.obs;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(100)),
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
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  filled: false,
                  hintText: "Type Message....",
                  hintStyle: Theme.of(context).textTheme.labelLarge),
            ),
          ),
          Obx(() => chatController.selectedImagePath.value == ''
              ? InkWell(
                  onTap: () async {
                    imagePickerBottomSheet(
                        context,
                        chatController.selectedImagePath,
                        imagePickerController);
                  },
                  child: Icon(
                    Icons.image,
                    color: dOnContainerColor,
                    size: 30,
                  ),
                )
              : SizedBox()),
          SizedBox(width: 10),
          Obx(
            () => InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (messageController.text.isNotEmpty ||
                    chatController.selectedImagePath.value.isNotEmpty) {
                  chatController.sendMessage(
                      userModel.id!, messageController.text, userModel);
                  messageController.clear();
                  message.value == '';
                }
              },
              child: chatController.isLoading.value
                  ? CircularProgressIndicator()
                  : SizedBox(
                      child: Icon(
                        message.value != "" ||
                                chatController.selectedImagePath.value != ''
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
