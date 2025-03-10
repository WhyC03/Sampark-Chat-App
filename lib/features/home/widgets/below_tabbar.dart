import 'package:flutter/material.dart';

belowTabbar(TabController tabController, BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: TabBar(
      controller: tabController,
      dividerHeight: 0,
      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      tabs: [
        Tab(
          text: 'Chats',
        ),
        Tab(
          text: 'Groups',
        ),
        Tab(
          text: 'Calls',
        ),
      ],
    ),
  );
}
