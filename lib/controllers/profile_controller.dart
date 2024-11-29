import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/models/my_profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileData = Profile().obs;

  // API call to fetch profile data
  Future<void> fetchProfileData() async {
    isLoading.value = true;
    try {
      // Retrieve token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(
          'token'); // Replace 'token' with the key used in SharedPreferences

      if (token == null) {
        Get.snackbar("Error", "User not authenticated");
        isLoading.value = false;
        return;
      }

      final response = await http.get(
        Uri.parse('http://206.189.138.45:8052/user/my-profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final result = Welcome.fromJson(json.decode(response.body));
        if (result.status == "Success") {
          profileData.value = result.data!;
          print(
              "Profile Data: ${profileData.value}"); // Print the profile data to check
        } else {
          Get.snackbar("Error", result.message ?? "Unknown error occurred");
        }
      } else {
        Get.snackbar("Error",
            "Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
