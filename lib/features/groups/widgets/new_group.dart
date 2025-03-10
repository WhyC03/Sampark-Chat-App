import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/features/contacts_list/controller/contact_controller.dart';
import 'package:sampark_app/features/groups/controller/group_controller.dart';
import 'package:sampark_app/features/groups/widgets/group_title.dart';
import 'package:sampark_app/features/groups/widgets/selected_member_list.dart';
import 'package:sampark_app/features/home/widgets/chat_tile.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({super.key});

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Group',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: groupController.groupMembers.isEmpty
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (groupController.groupMembers.isEmpty) {
              Get.snackbar("Error", "Please select atleast one member");
            } else {
              Get.to(() => GroupTitle());
            }
          },
          child: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectedMemberList(),
            SizedBox(height: 10),
            Text(
              'Contacts on Sampark',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: contactController.getContacts(),
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
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: Text("No Contacts Available"),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          groupController.selectMembers(snapshot.data![index]);
                        },
                        child: ChatTile(
                            imageUrl: snapshot.data![index].profilePic ??
                                AssetsImage.defaultProfilePic,
                            name: snapshot.data![index].name!,
                            lastText: snapshot.data![index].about ?? "",
                            lastTime: ""),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
