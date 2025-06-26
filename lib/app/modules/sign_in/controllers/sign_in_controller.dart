import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visit_tracker/app/data/providers/api_providers.dart';
import 'package:visit_tracker/app/routes/app_pages.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ApiProviders apiProviders = ApiProviders();
  var isLoading = false.obs;

  signIn() async {
    isLoading.value = true;
    var response = await apiProviders.signIn(
      emailController.text,
      passwordController.text,
    );

    if (response?.user != null) {
      isLoading.value = false;
      Get.offAllNamed(Routes.MAIN);
    } else {
      isLoading.value = false;
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
