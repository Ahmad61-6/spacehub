import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:spacehub/controller_binder.dart';
import 'package:spacehub/view/screens/auth/login_screen.dart';
import 'package:spacehub/view/utility/app_theme.dart';

class SpaceHub extends StatelessWidget {
  const SpaceHub({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appThemeData,
      home: LoginScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
