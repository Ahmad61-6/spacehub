import 'package:admin_app/controller_binder.dart';
import 'package:admin_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Workspace Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: ControllerBinder(),
      home: LoginScreen(),
    );
  }
}
