import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controllers/task_details_controller.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/space_widget.dart';
import 'package:task_management_app/widgets/text_widgets.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskDetailController taskDetailController =
      Get.put(TaskDetailController());
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String taskId = Get.arguments;

    // Fetch task details
    taskDetailController.fetchTaskDetail(taskId);

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: CustomTextWidget.plainTextContainerWidget(
          context: context,
          plainTextString: "Task Details",
          plainTextStringFontColor: colorBlack,
          plainTextStringFontSize: 20,
          plainTextStringFontWeight: FontWeight.bold,
          plainTextContainerWidth: 150,
          plainTextContainerAlignment: Alignment.centerLeft,
        ),
        titleSpacing: -8,
      ),
      body: Obx(() {
        if (taskDetailController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width /
              (MediaQuery.sizeOf(context).width / 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget.plainTextWidget(
                context: context,
                plainTextString:
                    capitalize(taskDetailController.taskTitle.value),
                plainTextStringFontColor: colorBlack,
                plainTextStringFontSize: 18,
                plainTextStringFontWeight: FontWeight.bold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                plainTextAlignment: TextAlign.left,
              ),
              SpaceWidget.spaceWidget(context: context, spaceHeight: 8),
              CustomTextWidget.plainTextWidget(
                context: context,
                plainTextString:
                    capitalize(taskDetailController.taskDescription.value),
                plainTextStringFontColor: colorBlack,
                plainTextStringFontSize: 14,
                plainTextStringFontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
                plainTextAlignment: TextAlign.left,
              ),
            ],
          ),
        );
      }),
    );
  }
}
