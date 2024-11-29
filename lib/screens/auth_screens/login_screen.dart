import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controllers/login_controller.dart';
import 'package:task_management_app/screens/auth_screens/registration_screen.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/icon_widget.dart';
import 'package:task_management_app/widgets/space_widget.dart';
import 'package:task_management_app/widgets/text_button_widget.dart';
import 'package:task_management_app/widgets/text_field_widget.dart';
import 'package:task_management_app/widgets/text_widgets.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).width /
            (MediaQuery.sizeOf(context).width / 16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpaceWidget.spaceWidget(context: context, spaceHeight: 60),
              CustomTextWidget.plainTextWidget(
                context: context,
                plainTextString: "Welcome Back!",
                plainTextStringFontColor: colorBlack,
                plainTextStringFontSize: 26,
                plainTextStringFontWeight: FontWeight.bold,
              ),
              SpaceWidget.spaceWidget(context: context, spaceHeight: 24),
              const Center(
                child: CustomIcon(
                  iconPath: "assets/images/loginSvg.svg",
                  iconHeight: 250,
                  iconWidth: 250,
                ),
              ),
              SpaceWidget.spaceWidget(context: context, spaceHeight: 36),
              MyFormField(
                controller: controller.emailController,
                hintText: "Email",
              ),
              SpaceWidget.spaceWidget(context: context, spaceHeight: 16),
              MyFormField(
                controller: controller.passwordController,
                hintText: "Password",
                suffixIcon: Icons.visibility_off_outlined,
              ),
              SpaceWidget.spaceWidget(context: context, spaceHeight: 36),
              Obx(() {
                return CustomButtonWidget(
                  onPressed: controller.isLoading.value
                      ? null
                      : () =>
                          controller.loginUser(), // Pass the callback directly
                  label: controller.isLoading.value ? "Loading..." : "Login",
                  buttonColor:
                      controller.isLoading.value ? Colors.grey : colorPrimary,
                  textColor: Colors.white,
                  buttonHeight: 55,
                  buttonWidth: double.infinity,
                  // borderRadius: BorderRadius.circular(12),
                );
              }),
              SpaceWidget.spaceWidget(context: context, spaceHeight: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget.plainTextWidget(
                    context: context,
                    plainTextString: "Don't have an account?",
                    plainTextStringFontColor: colorBlack,
                    plainTextStringFontSize: 14,
                    plainTextStringFontWeight: FontWeight.w400,
                  ),
                  SpaceWidget.spaceWidget(context: context, spaceWidth: 8),
                  TextButtonWidget(
                    onPressed: () {
                      Get.to(() => const RegistrationScreen());
                    },
                    text: "Register",
                    textColor: colorPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
