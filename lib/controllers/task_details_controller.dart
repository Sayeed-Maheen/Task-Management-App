import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TaskDetailController extends GetxController {
  var isLoading = true.obs;
  var taskTitle = ''.obs;
  var taskDescription = ''.obs;
  var creatorEmail = ''.obs;

  Future<void> fetchTaskDetail(String taskId) async {
    try {
      isLoading(true);

      // Retrieve the token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found. Please login again.");
        return;
      }

      final url = Uri.parse('http://206.189.138.45:8052/task/get-task/$taskId');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // Include the token in headers
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'Success') {
          final data = responseData['data'];
          taskTitle.value = data['title'] ?? 'No Title';
          taskDescription.value = data['description'] ?? 'No Description';
          creatorEmail.value = data['creator_email'] ?? 'No Email';
        } else {
          Get.snackbar("Error", responseData['message'] ?? "Task not found");
        }
      } else {
        print('Response Body: ${response.body}');
        Get.snackbar("Error", "Failed to fetch task details");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
