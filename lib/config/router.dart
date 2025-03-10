import 'package:get/get.dart';
import 'package:sampark_app/features/auth/screens/auth_screen.dart';
// import 'package:sampark_app/features/chat/screens/chat_screen.dart';

import 'package:sampark_app/features/contacts_list/screens/contacts_list_screen.dart';
import 'package:sampark_app/features/home/screens/home_screen.dart';
import 'package:sampark_app/features/update_user_profile/screens/update_user_profile_screen.dart';
import 'package:sampark_app/features/welcome/welcome_screen.dart';

var pagePath = [
  GetPage(
    name: "/auth-screen",
    page: () => AuthScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/welcome-screen",
    page: () => WelcomeScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/home-screen",
    page: () => HomeScreen(),
    transition: Transition.rightToLeft,
  ),
  // GetPage(
  //   name: "/chat-screen",
  //   page: () => ChatScreen(),
  //   transition: Transition.rightToLeft,
  // ),

  GetPage(
    name: "/update-profile-screen",
    page: () => UpdateUserProfileScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/contacts-list-page",
    page: () => ContactsListPage(),
    transition: Transition.rightToLeft,
  ),
];
