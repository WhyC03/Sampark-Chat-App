import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/features/call/pages/call_history_page.dart';
import 'package:sampark_app/features/contacts_list/controller/contact_controller.dart';
import 'package:sampark_app/features/groups/screens/groups_screen.dart';
import 'package:sampark_app/features/home/widgets/below_tabbar.dart';
import 'package:sampark_app/features/home/widgets/contacts_list.dart';
import 'package:sampark_app/features/profile/screens/profile_screen.dart';
import 'package:sampark_app/features/chat/userprofile/controller/user_profile_controller.dart';
import 'package:sampark_app/status_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    ContactController contactController = Get.put(ContactController());
    Get.put(ProfileController());
    Get.put(StatusController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AssetsImage.appIconSVG,
            width: 10,
          ),
        ),
        title: Text(
          "Sampark",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              contactController.getChatRoomList();
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Get.toNamed('/user-profile-screen');
              Get.to(() => ProfileScreen());
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        bottom: belowTabbar(tabController, context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TabBarView(
          controller: tabController,
          children: [
            ContactsList(),
            GroupsScreen(),
            CallHistoryPage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/contacts-list-page");
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
