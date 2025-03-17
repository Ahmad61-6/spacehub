import 'package:get/get.dart';

import 'controllers/auth/password_visibility_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(PasswordVisibilityController());
  }
}
