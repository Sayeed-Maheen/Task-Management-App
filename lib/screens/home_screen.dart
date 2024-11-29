import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controllers/all_tasks_controller.dart';
import 'package:task_management_app/controllers/delete_task_controller.dart';
import 'package:task_management_app/controllers/logout_controller.dart';
import 'package:task_management_app/screens/create_task_screen.dart';
import 'package:task_management_app/screens/profile_screen.dart';
import 'package:task_management_app/screens/task_details_screen.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/space_widget.dart';
import 'package:task_management_app/widgets/text_widgets.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final LogoutController logoutController = Get.put(LogoutController());
  final DeleteTaskController deleteTaskController =
      Get.put(DeleteTaskController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: CustomTextWidget.plainTextContainerWidget(
          context: context,
          plainTextString: "Home Screen",
          plainTextStringFontColor: colorBlack,
          plainTextStringFontSize: 20,
          plainTextStringFontWeight: FontWeight.bold,
          plainTextContainerWidth: 150,
          plainTextContainerAlignment: Alignment.centerLeft,
        ),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                logoutController.logout();
              } else if (value == 'profile') {
                Get.to(() => ProfileScreen());
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (taskController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (taskController.taskList.isEmpty) {
          return const Center(
            child: Text('No tasks found'),
          );
        }

        return ListView.builder(
          itemCount: taskController.taskList.length,
          itemBuilder: (context, index) {
            final task = taskController.taskList[index];
            return InkWell(
              onTap: () {
                Get.to(() => TaskDetailScreen(), arguments: task.id);
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width /
                      (MediaQuery.sizeOf(context).width / 16),
                  right: MediaQuery.sizeOf(context).width /
                      (MediaQuery.sizeOf(context).width / 16),
                  bottom: MediaQuery.sizeOf(context).width /
                      (MediaQuery.sizeOf(context).width / 16),
                ),
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).width /
                    (MediaQuery.sizeOf(context).width / 16)),
                decoration: BoxDecoration(
                  color:
                      colorPrimaryLightest, // Use the required color parameter
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: colorBlackLight.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width /
                              (MediaQuery.sizeOf(context).width / 250)),
                          child: CustomTextWidget.plainTextWidget(
                            context: context,
                            plainTextString:
                                capitalize(task.title ?? 'No Title'),
                            plainTextStringFontColor: colorBlack,
                            plainTextStringFontSize: 18,
                            plainTextStringFontWeight: FontWeight.bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            plainTextAlignment: TextAlign.left,
                          ),
                        ),
                        SpaceWidget.spaceWidget(
                            context: context, spaceHeight: 8),
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width /
                              (MediaQuery.sizeOf(context).width / 250)),
                          child: CustomTextWidget.plainTextWidget(
                            context: context,
                            plainTextString: capitalize(
                                task.description ?? 'No Description'),
                            plainTextStringFontColor: colorBlack,
                            plainTextStringFontSize: 14,
                            plainTextStringFontWeight: FontWeight.w400,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            plainTextAlignment: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const CircleAvatar(
                          backgroundColor: colorWhite,
                          child: Icon(Icons.delete, color: colorRed)),
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text("Delete Task"),
                            content: const Text(
                                "Are you sure you want to delete this task?"),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back(); // Close the dialog
                                  deleteTaskController
                                      .deleteTask(task.id ?? '');
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateTaskScreen()),
        backgroundColor: colorPrimary,
        child: const Icon(
          Icons.create,
          color: colorWhite,
        ),
      ),
    );
  }
}
