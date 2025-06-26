import 'package:get/get.dart';
import 'package:visit_tracker/app/modules/analytics/controllers/analytics_controller.dart';
import 'package:visit_tracker/app/modules/home/controllers/home_controller.dart';
import 'package:visit_tracker/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AnalyticsController>(() => AnalyticsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
