import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controllers/profile_controller.dart';
import 'package:task_management_app/screens/profile_update_screen.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/space_widget.dart';
import 'package:task_management_app/widgets/text_widgets.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch profile data when the screen loads
    _controller.fetchProfileData();

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: CustomTextWidget.plainTextContainerWidget(
          context: context,
          plainTextString: "Profile Info",
          plainTextStringFontColor: colorBlack,
          plainTextStringFontSize: 20,
          plainTextStringFontWeight: FontWeight.bold,
          plainTextContainerWidth: 150,
          plainTextContainerAlignment: Alignment.centerLeft,
        ),
        titleSpacing: -8,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Get.to(() =>
                  ProfileUpdateScreen(profile: _controller.profileData.value));
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = _controller.profileData.value;
        return profile.id == null
            ? const Center(child: Text("No profile data found"))
            : Padding(
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).width /
                    (MediaQuery.sizeOf(context).width / 16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the image if available
                    if (profile.image != null && profile.image!.isNotEmpty)
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            'http://206.189.138.45:8052/${profile.image}', // Prepend base URL
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error,
                                  size: 100); // Error icon if image fails
                            },
                          ),
                        ),
                      )
                    else
                      const Text('No profile image available'),
                    SpaceWidget.spaceWidget(context: context, spaceHeight: 60),
                    ProfileDetailRow(
                      label: "Name",
                      value:
                          "${profile.firstName ?? "N/A"} ${profile.lastName ?? "N/A"}",
                    ),
                    ProfileDetailRow(
                      label: "Last Name",
                      value: profile.lastName ?? "N/A",
                    ),
                    ProfileDetailRow(
                      label: "Email",
                      value: profile.email ?? "N/A",
                    ),
                    ProfileDetailRow(
                      label: "Address",
                      value: profile.address ?? "N/A",
                    ),
                  ],
                ),
              );
      }),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).width /
              (MediaQuery.sizeOf(context).width / 10)),
      child: Row(
        children: [
          CustomTextWidget.plainTextWidget(
            context: context,
            plainTextString: "$label:  ",
            plainTextStringFontColor: colorBlack,
            plainTextStringFontSize: 16,
            plainTextStringFontWeight: FontWeight.bold,
          ),
          Flexible(
            child: CustomTextWidget.plainTextWidget(
              context: context,
              plainTextString: value,
              plainTextStringFontColor: colorBlack,
              plainTextStringFontSize: 16,
              plainTextStringFontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
