import 'package:get/get.dart';
import 'package:spacehub/controllers/main_bottom_nav_bar_controller.dart';

import 'controllers/auth/password_visibility_controller.dart';
import 'controllers/auth/terms_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(PasswordVisibilityController());
    Get.put(TermsController());
    Get.put(MainBottomNavBarController());
  }
}
