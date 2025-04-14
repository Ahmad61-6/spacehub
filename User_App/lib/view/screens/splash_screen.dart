import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacehub/controllers/map_controller.dart';

import '../../controllers/auth/auth_controller.dart';
import 'auth/login_screen.dart';
import 'main_bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find();

  @override
  void initState() {
    super.initState();
    Get.find<MapController>().fetchLocation();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Check if user was previously logged in
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('userEmail');

    if (userEmail != null) {
      // User was logged in - fetch fresh data
      await _authController.fetchUserData(userEmail);
    }

    Get.offAll(() =>
        _authController.user != null ? MainBottomNavBar() : LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
