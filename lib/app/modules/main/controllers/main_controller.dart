import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../analytics/views/analytics_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';

class MainController extends GetxController {
  var selectedTab = 0.obs;

  final List<Widget> screens = [
    const HomeView(),
    AnalyticsView(),
    const ProfileView(),
  ];
  var navItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(
      icon: Icon(Icons.stacked_bar_chart),
      label: "Analytics",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_2_outlined),
      label: "Profile",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
