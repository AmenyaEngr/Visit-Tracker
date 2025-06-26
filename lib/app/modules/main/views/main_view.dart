import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: controller.screens[controller.selectedTab.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedTab.value,
          onTap: (index) => controller.selectedTab.value = index,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: controller.navItem,
        ),
      );
    });
  }
}
