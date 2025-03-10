import 'package:flutter/material.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/features/groups/groupInfo/group_members_info.dart';
import 'package:sampark_app/features/home/widgets/chat_tile.dart';
import 'package:sampark_app/models/group_model.dart';

class GroupInfoScreen extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfoScreen({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          groupModel.name!,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),
              GroupMembersInfo(
                profilePic: groupModel.profileUrl == ''
                    ? AssetsImage.defaultProfilePic
                    : groupModel.profileUrl!,
                userName: groupModel.name ?? '',
                userEmail: groupModel.description ?? 'No group Description',
                groupId: groupModel.id!,
              ),
              SizedBox(height: 10),
              Text(
                "Members",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 10),
              if (groupModel.members != null && groupModel.members!.isNotEmpty)
                Column(
                  children: groupModel.members!
                      .map(
                        (member) => ChatTile(
                          imageUrl: member.profilePic ??
                              AssetsImage.defaultProfilePic,
                          name: member.name ?? 'Unknown Member',
                          lastText: member.email ?? 'No email',
                          lastTime: member.role == 'Admin' ? 'Admin' : 'User',
                        ),
                      )
                      .toList(),
                )
              else
                const Center(
                  child: Text('No members found'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
