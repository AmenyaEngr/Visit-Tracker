import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/input_textfield_widget.dart';
import '../../../common_widgets/outlined_button_widget.dart';
import '../../../common_widgets/sign_in_and_up_row.dart';
import '../../../dimens/dimens.dart';
import '../../../routes/app_pages.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(mediumSize),
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Text("Create Account", style: AppTextStyles.extraLargeHeader),

                  extraLargeVerticalSpacing,

                  const Text(
                    "Simply track your visits with us",
                    style: TextStyle(fontSize: mediumSize),
                  ),
                  largeVerticalSpacing,
                  InputTextFieldWidget(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    hintText: "Enter your first name",
                    labelText: "First Name",
                    editingController: controller.firstNameController,
                  ),
                  mediumVerticalSpacing,
                  InputTextFieldWidget(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    hintText: "Enter your last name",
                    labelText: "Last Name",
                    editingController: controller.lastNameController,
                  ),
                  mediumVerticalSpacing,
                  InputTextFieldWidget(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: "Enter your Email",
                    labelText: "Email address",
                    errorText: controller.emailErrorMessage.value,
                    editingController: controller.emailAddressController,
                  ),
                  mediumVerticalSpacing,
                  PasswordTextFieldWidget(
                    hintText: "Create Password",
                    labelText: "Password",
                    errorText: controller.passwordErrorMessage.value,
                    passwordTextEditController: controller.passwordController,
                  ),
                  mediumVerticalSpacing,
                  OutlinedButtonWidget(
                    onClick: () {
                      controller.signUp();
                    },
                    name: 'Create Account',
                    child:
                        controller.isLoading.value
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                            : null,
                  ),
                  mediumVerticalSpacing,
                  SignInAndUpRow(
                    desc: "Already a member? ",
                    action: "Login",
                    onClick: () {
                      Get.toNamed(Routes.SIGN_IN);
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
