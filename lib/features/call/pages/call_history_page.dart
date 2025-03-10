import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/features/chat/controller/chat_controller.dart';
import 'package:sampark_app/features/home/widgets/chat_tile.dart';

class CallHistoryPage extends StatelessWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return StreamBuilder(
      stream: chatController.getCalls(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ChatTile(
                imageUrl: snapshot.data![index].callerProfilePic ??
                    AssetsImage.defaultProfilePic,
                name: snapshot.data![index].callerName ?? '',
                lastText: snapshot.data![index].type ?? '',
                lastTime: snapshot.data![index].time ?? '',
              );
            },
            itemCount: snapshot.data!.length,
          );
        } else {
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
