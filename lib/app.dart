import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:spacehub/controller_binder.dart';
import 'package:spacehub/view/utility/app_theme.dart';
import 'package:spacehub/view/widgets/auth_redirect.dart';

class SpaceHub extends StatelessWidget {
  const SpaceHub({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appThemeData,
      home: const AuthRedirect(),
      initialBinding: ControllerBinder(),
    );
  }
}
