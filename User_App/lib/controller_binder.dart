import 'package:get/get.dart';
import 'package:spacehub/controllers/auth/auth_controller.dart';
import 'package:spacehub/controllers/main_bottom_nav_bar_controller.dart';
import 'package:spacehub/controllers/user_controller.dart';

import 'controllers/auth/password_visibility_controller.dart';
import 'controllers/auth/terms_controller.dart';
import 'controllers/category_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(PasswordVisibilityController());
    Get.put(TermsController());
    Get.put(MainBottomNavBarController());
    Get.put(CategoryController());
    Get.put(AuthController());
    Get.put(UserController());
  }
}
