import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/features/auth/controller/auth_controller.dart';
import 'package:sampark_app/features/profile/screens/profile_screen.dart';
import 'package:sampark_app/features/chat/userprofile/widgets/user_info.dart';
import 'package:sampark_app/models/user_model.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel userModel;
  const UserProfileScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ProfileScreen());
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 5),
            UserInfo(
              profilePic: userModel.profilePic ?? AssetsImage.defaultProfilePic,
              userName: userModel.name ?? '',
              userEmail: userModel.email ?? '',
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                authController.signOut();
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
