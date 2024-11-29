import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/models/my_profile_model.dart';
import 'profile_controller.dart';

class ProfileUpdateController extends GetxController {
  var isLoading = false.obs;
  var selectedImage = Rxn<XFile>();
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final addressController = TextEditingController().obs;

  void initializeControllers(Profile profile) {
    firstNameController.value.text = profile.firstName ?? "";
    lastNameController.value.text = profile.lastName ?? "";
    addressController.value.text = profile.address ?? "";
  }

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        selectedImage.value = pickedFile;
      }
    } catch (e) {
      _showErrorSnackbar(
          "Image Selection Error", "Failed to pick image: ${e.toString()}");
    }
  }

  String? validateInput(String input, String fieldName, {int minLength = 2}) {
    if (input.isEmpty) {
      return "$fieldName cannot be empty";
    }
    if (input.length < minLength) {
      return "$fieldName must be at least $minLength characters long";
    }
    if (fieldName == "First Name" || fieldName == "Last Name") {
      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(input)) {
        return "$fieldName should contain only alphabetic characters";
      }
    }
    return null;
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  Future<void> updateProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "No authentication token found");
        return;
      }

      const url = 'http://206.189.138.45:8052/user/update-profile';
      final request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      request.fields['firstName'] = firstNameController.value.text.trim();
      request.fields['lastName'] = lastNameController.value.text.trim();
      request.fields['address'] = addressController.value.text.trim();

      if (selectedImage.value != null) {
        final imageFile = File(selectedImage.value!.path);
        request.files.add(await http.MultipartFile.fromPath(
          'profile_image',
          imageFile.path,
          filename:
              'profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
          contentType: MediaType('image', 'jpg'),
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == "Success") {
          Get.back();
          Get.snackbar("Success", "Profile updated successfully");

          // Fetch the updated profile data after a successful update
          Get.find<ProfileController>().fetchProfileData();
          selectedImage.value = null;
        } else {
          Get.snackbar("Error", result['message'] ?? "Update failed");
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
    }
  }

  @override
  void onClose() {
    firstNameController.value.dispose();
    lastNameController.value.dispose();
    addressController.value.dispose();
    super.onClose();
  }
}
