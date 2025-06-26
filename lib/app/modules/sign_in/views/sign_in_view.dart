import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../colors/app_colors.dart';
import '../../../common_widgets/input_textfield_widget.dart';
import '../../../common_widgets/outlined_button_widget.dart';
import '../../../common_widgets/sign_in_and_up_row.dart';
import '../../../dimens/dimens.dart';
import '../../../routes/app_pages.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(mediumSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                "assets/images/analysis.png",
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(height: mediumSize),
            const Text(
              "Welcome Back!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: largeSize,
              ),
            ),

            const Text("Sign in to continue"),
            const SizedBox(height: extraLargeSize),
            InputTextFieldWidget(
              prefixIcon: Icon(Icons.email_outlined),
              hintText: 'Email Address',
              labelText: "Email address",
              editingController: controller.emailController,
            ),
            const SizedBox(height: mediumSize),
            PasswordTextFieldWidget(
              hintText: "Password",
              labelText: "Password",
              passwordTextEditController: controller.passwordController,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // todo
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(color: primaryColor, fontSize: 12),
                ),
              ),
            ),
            Obx(() {
              return OutlinedButtonWidget(
                onClick: () {
                  controller.signIn();
                },
                name: "Continue",
                child:
                    controller.isLoading.value
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                        : null,
              );
            }),
            mediumVerticalSpacing,
            SignInAndUpRow(
              desc: 'Do not have an account? ',
              action: "Sign Up",
              onClick: () {
                Get.toNamed(Routes.SIGN_UP);
              },
            ),
          ],
        ),
      ),
    );
  }
}
