import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_management_app/screens/auth_screens/login_screen.dart';

class VerificationController extends GetxController {
  final TextEditingController codeController = TextEditingController();
  final RxBool isLoading = false.obs; // Observable for loading state

  Future<void> verifyUser(String email) async {
    if (codeController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter the verification code",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true; // Show loading indicator

    try {
      final url = Uri.parse('http://206.189.138.45:8052/user/activate-user');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "email": email,
          "code": codeController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'Success') {
          Get.snackbar(
            "Success",
            responseData['message'] ?? 'Account activated successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white,
          );

          // Navigate to login screen
          Get.to(LoginScreen()); // Replace with your LoginScreen route
        } else {
          Get.snackbar(
            "Error",
            responseData['message'] ?? 'Failed to activate account',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to activate account. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }
}
