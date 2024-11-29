import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/controllers/all_tasks_controller.dart';

class DeleteTaskController extends GetxController {
  var isLoading = false.obs;

  Future<void> deleteTask(String taskId) async {
    try {
      isLoading(true);

      // Retrieve the token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found. Please login again.");
        return;
      }

      final url =
          Uri.parse('http://206.189.138.45:8052/task/delete-task/$taskId');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'Success') {
          Get.snackbar("Success", "Task deleted successfully");
          Get.find<TaskController>().fetchTasks(); // Refresh task list
        } else {
          Get.snackbar(
              "Error", responseData['message'] ?? "Failed to delete task");
        }
      } else {
        Get.snackbar("Error", "Failed to delete task. ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
