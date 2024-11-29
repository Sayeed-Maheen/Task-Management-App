import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

import 'package:task_management_app/screens/auth_screens/verification_screen.dart';

class RegistrationController extends GetxController {
  var fileController = ''.obs; // Observable string for file path
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  void updateImageFile(String path) {
    fileController.value = path; // This will trigger UI update
    update(); // Force GetX to rebuild widgets
  }

  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      try {
        final uri = Uri.parse('http://206.189.138.45:8052/user/register');

        var request = http.MultipartRequest('POST', uri);

        // Add text fields
        request.fields['firstName'] = firstNameController.text;
        request.fields['lastName'] = lastNameController.text;
        request.fields['email'] = emailController.text;
        request.fields['password'] = passwordController.text;
        request.fields['address'] = addressController.text;

        // Add file (if selected)
        // In RegistrationController
        // In RegistrationController
        if (fileController.value.isNotEmpty) {
          File imageFile = File(fileController.value); // Use `.value`
          request.files.add(await http.MultipartFile.fromPath(
            'file',
            imageFile.path,
            contentType:
                MediaType('image', 'jpeg'), // Adjust mime type if needed
          ));
        }

        // Send the request
        final response = await request.send();

        if (response.statusCode == 200) {
          Get.to(() => VerificationScreen(email: emailController.text));
          Get.snackbar('Success',
              'Registration successful. Check your email to activate your account.');
        } else {
          Get.snackbar('Error', 'Registration failed. Please try again.');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred. Please try again later.');
      }
    }
  }
}
