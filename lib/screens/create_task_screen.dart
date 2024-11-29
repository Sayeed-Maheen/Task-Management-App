import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controllers/task_create_controller.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/space_widget.dart';
import 'package:task_management_app/widgets/text_field_widget.dart';
import 'package:task_management_app/widgets/text_widgets.dart';

class CreateTaskScreen extends StatelessWidget {
  final TaskCreateController controller = Get.put(TaskCreateController());

  CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: CustomTextWidget.plainTextContainerWidget(
          context: context,
          plainTextString: "Create Task",
          plainTextStringFontColor: colorBlack,
          plainTextStringFontSize: 20,
          plainTextStringFontWeight: FontWeight.bold,
          plainTextContainerWidth: 150,
          plainTextContainerAlignment: Alignment.centerLeft,
        ),
        titleSpacing: -8,
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).width /
            (MediaQuery.sizeOf(context).width / 16)),
        child: Column(
          children: [
            MyFormField(
              controller: controller.titleController,
              hintText: "Title",
            ),
            SpaceWidget.spaceWidget(context: context, spaceHeight: 16),
            MyFormField(
              controller: controller.descriptionController,
              hintText: "Description",
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            Obx(() {
              return CustomButtonWidget(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        controller.createTask();
                        Get.back();
                      },
                label:
                    controller.isLoading.value ? "Creating..." : "Create Task",
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
