import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/screens/auth_screens/login_screen.dart';
import 'package:task_management_app/screens/home_screen.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/text_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    checkLoginStatus();
  }

  // Function to check login status and navigate accordingly
  Future<void> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await Future.delayed(const Duration(seconds: 2));

    if (token != null) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to avoid ticker leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextWidget.plainTextWidget(
              context: context,
              plainTextString: "Task Management App",
              maxLines: 1,
              plainTextStringFontColor: colorWhite,
              plainTextStringFontSize: 26,
              plainTextStringFontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: (MediaQuery.sizeOf(context).height /
            (MediaQuery.sizeOf(context).height / 60)),
        width: (MediaQuery.sizeOf(context).width /
            (MediaQuery.sizeOf(context).width / 100)),
        child: SpinKitFadingCube(
          color: colorWhite,
          size: 25,
          controller: _controller,
        ),
      ),
    );
  }
}
