import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sampark_app/config/colors.dart';
import 'package:sampark_app/config/images.dart';

class UserInfo extends StatelessWidget {
  final String profilePic;
  final String userName;
  final String userEmail;
  const UserInfo(
      {super.key,
      required this.profilePic,
      required this.userName,
      required this.userEmail});

  @override
  Widget build(BuildContext context) {
    // ProfileController profileController = Get.put(ProfileController());
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: profilePic,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            userName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            userEmail,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: Color(0xff039c00),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Call",
                      style: TextStyle(
                        color: Color(0xff039c00),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AssetsImage.appIconSVG,
                        width: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Add",
                        style: TextStyle(color: dPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Icon(
                      Icons.video_camera_front_outlined,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Video Call",
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
