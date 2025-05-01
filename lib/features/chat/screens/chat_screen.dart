import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/features/call/notification/controller/call_controller.dart';
import 'package:sampark_app/features/call/pages/audio_call_page.dart';
import 'package:sampark_app/features/call/pages/video_call_page.dart';
import 'package:sampark_app/features/chat/controller/chat_controller.dart';
import 'package:sampark_app/features/chat/userprofile/screens/user_profile_screen.dart';
import 'package:sampark_app/features/chat/widgets/chat_bubble.dart';
import 'package:sampark_app/features/chat/widgets/typing_space.dart';
import 'package:sampark_app/features/chat/userprofile/controller/user_profile_controller.dart';
import 'package:sampark_app/models/chat_model.dart';
import 'package:sampark_app/models/user_model.dart';

class ChatScreen extends StatelessWidget {
  final UserModel userModel;
  const ChatScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    CallController callController = Get.put(CallController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(() => UserProfileScreen(
                  userModel: userModel,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              // width: 50,
              // height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl:
                      userModel.profilePic ?? AssetsImage.defaultProfilePic,
                  width: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(() => UserProfileScreen(
                  userModel: userModel,
                ));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name ?? "User",
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  StreamBuilder(
                    stream: chatController.getStatus(userModel.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          '......',
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      } else {
                        return Text(
                          snapshot.data!.status ?? "",
                          style: TextStyle(
                              fontSize: 12,
                              color: snapshot.data!.status == 'Offline'
                                  ? Colors.grey
                                  : Colors.green),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => VideoCallPage(target: userModel),
              );
              callController.callAction(
                  userModel, profileController.currentUser.value, 'video');
            },
            icon: Icon(
              Icons.video_call_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(
                () => AudioCallPage(target: userModel),
              );
              callController.callAction(
                  userModel, profileController.currentUser.value, 'audio');
            },
            icon: Icon(Icons.call_outlined),
          ),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  StreamBuilder<List<ChatModel>>(
                    stream: chatController.getMessages(userModel.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      }
                      if (snapshot.data == null) {
                        return Center(
                          child: Text("No Messages"),
                        );
                      } else {
                        return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime timeStamp = DateTime.parse(
                                snapshot.data![index].timeStamp!);
                            String formattedTime =
                                DateFormat('hh:mm a').format(timeStamp);
                            return ChatBubble(
                              text: snapshot.data![index].message!,
                              isComing: snapshot.data![index].senderId !=
                                  profileController.currentUser.value.id,
                              time: formattedTime,
                              status: 'read',
                              imageUrl: snapshot.data![index].imageUrl ?? "",
                            );
                          },
                        );
                      }
                    },
                  ),
                  Obx(
                    () => (chatController.selectedImagePath.value != "")
                        ? Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(
                                          File(
                                            chatController
                                                .selectedImagePath.value,
                                          ),
                                        ),
                                        fit: BoxFit.contain),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 500,
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: IconButton(
                                    onPressed: () {
                                      chatController.selectedImagePath.value =
                                          "";
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
            TypingSpace(userModel: userModel),
          ],
        ),
      ),
    );
  }
}
