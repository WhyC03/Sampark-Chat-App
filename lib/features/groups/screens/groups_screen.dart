import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/features/groups/controller/group_controller.dart';
import 'package:sampark_app/features/groups/screens/group_chat_screen.dart';
import 'package:sampark_app/features/home/widgets/chat_tile.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return RefreshIndicator(
      onRefresh: () {
        return groupController.getGroups();
      },
      child: Obx(
        () => groupController.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : groupController.groupList.isEmpty
                ? Center(
                    child: Text("Create A New Group"),
                  )
                : ListView(
                    children: groupController.groupList
                        .map(
                          (group) => InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Get.to(() => GroupChatScreen(groupModel: group));
                            },
                            child: ChatTile(
                                imageUrl: group.profileUrl == ''
                                    ? AssetsImage.defaultProfilePic
                                    : group.profileUrl!,
                                name: group.name!,
                                lastText: 'Group Created',
                                lastTime: 'Just Now'),
                          ),
                        )
                        .toList(),
                  ),
      ),
    );
  }
}
