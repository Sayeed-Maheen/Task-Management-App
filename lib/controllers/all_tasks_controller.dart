import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/models/all_tasks_model.dart';

class TaskController extends GetxController {
  var isLoading = true.obs; // Observable for loading state
  var taskList = <MyTask>[].obs; // Observable list of tasks

  @override
  void onInit() {
    super.onInit();
    fetchTasks(); // Fetch tasks when the controller is initialized
  }

  Future<void> fetchTasks() async {
    try {
      isLoading(true); // Set loading to true

      // Retrieve the token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar('Error', 'Authentication token not found. Please log in.');
        return;
      }

      // Make the API call with the token in the headers
      final response = await http.get(
        Uri.parse('http://206.189.138.45:8052/task/get-all-task'),
        headers: {
          'Authorization': 'Bearer $token', // Include the token
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final Welcome welcome = Welcome.fromJson(jsonResponse);

        if (welcome.data?.myTasks != null) {
          taskList.value = welcome.data!.myTasks!;
        } else {
          taskList.clear(); // Clear the list if no tasks are found
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch tasks: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false); // Set loading to false
    }
  }
}
