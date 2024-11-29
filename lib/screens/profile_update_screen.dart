import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controllers/profile_update_controller.dart';
import 'package:task_management_app/models/my_profile_model.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/space_widget.dart';
import 'package:task_management_app/widgets/text_button_widget.dart';
import 'package:task_management_app/widgets/text_field_widget.dart';
import 'package:task_management_app/widgets/text_widgets.dart';

class ProfileUpdateScreen extends StatelessWidget {
  final Profile profile;
  final ProfileUpdateController controller = Get.put(ProfileUpdateController());

  ProfileUpdateScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with the passed profile data
    controller.initializeControllers(profile);

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: CustomTextWidget.plainTextContainerWidget(
          context: context,
          plainTextString: "Update Profile Info",
          plainTextStringFontColor: colorBlack,
          plainTextStringFontSize: 20,
          plainTextStringFontWeight: FontWeight.bold,
          plainTextContainerWidth: 200,
          plainTextContainerAlignment: Alignment.centerLeft,
        ),
        titleSpacing: -8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.selectedImage.value !=
                                  null
                              ? FileImage(
                                  File(controller.selectedImage.value!.path))
                              : (profile.image != null
                                  ? NetworkImage(
                                      'http://206.189.138.45:8052/${profile.image}')
                                  : null) as ImageProvider?,
                          child: controller.selectedImage.value == null &&
                                  profile.image == null
                              ? const Icon(Icons.camera_alt, size: 50)
                              : null,
                        ),
                      ),
                      SpaceWidget.spaceWidget(context: context, spaceHeight: 8),
                      Center(
                        child: TextButtonWidget(
                          onPressed: controller.pickImage,
                          text: "Tap to Pick Image",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          textColor: colorBlack,
                        ),
                      ),
                      SpaceWidget.spaceWidget(
                          context: context, spaceHeight: 24),
                      MyFormField(
                        controller: controller.firstNameController.value,
                        hintText: "First Name",
                      ),
                      SpaceWidget.spaceWidget(
                          context: context, spaceHeight: 16),
                      MyFormField(
                        controller: controller.lastNameController.value,
                        hintText: "Last Name",
                      ),
                      SpaceWidget.spaceWidget(
                          context: context, spaceHeight: 16),
                      MyFormField(
                        controller: controller.addressController.value,
                        hintText: "Address",
                      ),
                      SpaceWidget.spaceWidget(
                          context: context, spaceHeight: 24),
                      CustomButtonWidget(
                        onPressed: controller.updateProfile,
                        label: "Update",
                        buttonColor: colorPrimary,
                        textColor: Colors.white,
                        buttonHeight: 55,
                        buttonWidth: double.infinity,
                        // borderRadius: BorderRadius.circular(12),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
