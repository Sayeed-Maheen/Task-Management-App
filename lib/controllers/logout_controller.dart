import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/screens/auth_screens/login_screen.dart';

class LogoutController extends GetxController {
  // Method to handle user logout
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');

    // Navigate to the login screen after logout
    Get.offAll(() => LoginScreen());
  }
}
