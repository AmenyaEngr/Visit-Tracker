import 'package:get/get.dart';
import 'package:visit_tracker/app/data/providers/api_providers.dart';
import 'package:visit_tracker/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  ApiProviders apiProviders = ApiProviders();

  signOut() async {
    bool signOut = await apiProviders.signOut();

    if (signOut) {
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }

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
