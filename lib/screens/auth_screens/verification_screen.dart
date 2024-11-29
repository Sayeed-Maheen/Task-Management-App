import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controllers/verification_controller.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/space_widget.dart';
import 'package:task_management_app/widgets/text_field_widget.dart';
import 'package:task_management_app/widgets/text_widgets.dart';

class VerificationScreen extends StatelessWidget {
  final String email; // Email passed from RegistrationScreen
  final VerificationController controller = Get.put(VerificationController());

  VerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).width /
            (MediaQuery.sizeOf(context).width / 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpaceWidget.spaceWidget(context: context, spaceHeight: 60),
            CustomTextWidget.plainTextWidget(
              context: context,
              plainTextString: "Verify Account!",
              plainTextStringFontColor: colorBlack,
              plainTextStringFontSize: 26,
              plainTextStringFontWeight: FontWeight.bold,
            ),
            SpaceWidget.spaceWidget(context: context, spaceHeight: 24),
            CustomTextWidget.plainTextWidget(
              context: context,
              plainTextString:
                  "Check your email $email to activate your account.",
              plainTextStringFontColor: colorBlack,
              plainTextStringFontSize: 16,
              plainTextStringFontWeight: FontWeight.w400,
            ),
            SpaceWidget.spaceWidget(context: context, spaceHeight: 40),
            MyFormField(
              controller: controller.codeController,
              hintText: "Verification Code",
              keyboardType: TextInputType.number,
            ),
            SpaceWidget.spaceWidget(context: context, spaceHeight: 16),
            Obx(() {
              return CustomButtonWidget(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.verifyUser(email),
                label: controller.isLoading.value ? "Loading..." : "Verify",
                buttonColor:
                    controller.isLoading.value ? Colors.grey : colorPrimary,
                textColor: Colors.white,
                buttonHeight: 55,
                buttonWidth: double.infinity,
                // borderRadius: BorderRadius.circular(12),
              );
            }),
          ],
        ),
      ),
    );
  }
}
