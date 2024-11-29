import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management_app/controllers/registration_controller.dart';
import 'package:task_management_app/screens/auth_screens/login_screen.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'dart:io';

import 'package:task_management_app/widgets/space_widget.dart';
import 'package:task_management_app/widgets/text_button_widget.dart';
import 'package:task_management_app/widgets/text_field_widget.dart';
import 'package:task_management_app/widgets/text_widgets.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());

    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width /
              (MediaQuery.sizeOf(context).width / 16)),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceWidget.spaceWidget(context: context, spaceHeight: 30),
                CustomTextWidget.plainTextWidget(
                  context: context,
                  plainTextString: "Hello There!",
                  plainTextStringFontColor: colorBlack,
                  plainTextStringFontSize: 26,
                  plainTextStringFontWeight: FontWeight.bold,
                ),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 4),
                CustomTextWidget.plainTextWidget(
                  context: context,
                  plainTextString: "Register to the app",
                  plainTextStringFontColor: colorBlack,
                  plainTextStringFontSize: 14,
                  plainTextStringFontWeight: FontWeight.w400,
                ),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 40),
                Obx(() {
                  return controller.fileController.value.isNotEmpty
                      ? Center(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  File(controller.fileController.value),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: colorPrimaryLight,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Center(
                                child: Icon(
                              Icons.person,
                              color: colorWhite,
                              size: 80,
                            )),
                          ),
                        );
                }),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 8),
                Center(
                  child: TextButtonWidget(
                    onPressed: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        controller.updateImageFile(pickedFile.path);
                      }
                    },
                    text: "Tap to Pick Image",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    textColor: colorBlack,
                  ),
                ),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 24),
                MyFormField(
                  controller: controller.firstNameController,
                  hintText: "First Name",
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your first name' : null,
                ),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 16),
                MyFormField(
                  controller: controller.lastNameController,
                  hintText: "Last Name",
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your last name' : null,
                ),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 16),
                MyFormField(
                  controller: controller.emailController,
                  hintText: "Email",
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null,
                ),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 16),
                MyFormField(
                  controller: controller.passwordController,
                  hintText: "Password",
                  suffixIcon: Icons.visibility_off_outlined,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a password' : null,
                ),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 16),
                MyFormField(
                  controller: controller.addressController,
                  hintText: "Address",
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your address' : null,
                ),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 16),
                CustomButtonWidget(
                  onPressed: controller.registerUser,
                  label: "Register",
                  buttonColor: colorPrimary,
                  textColor: Colors.white,
                  buttonHeight: 55,
                  buttonWidth: double.infinity,
                  // borderRadius: BorderRadius.circular(12),
                ),
                SpaceWidget.spaceWidget(context: context, spaceHeight: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget.plainTextWidget(
                      context: context,
                      plainTextString: "Already have an account?",
                      plainTextStringFontColor: colorBlack,
                      plainTextStringFontSize: 14,
                      plainTextStringFontWeight: FontWeight.w400,
                    ),
                    SpaceWidget.spaceWidget(context: context, spaceWidth: 4),
                    TextButtonWidget(
                      onPressed: () {
                        Get.offAll(() => LoginScreen());
                      },
                      text: "Login",
                      textColor: colorPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
