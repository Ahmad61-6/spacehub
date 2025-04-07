import 'package:admin_app/controllers/admin_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminController());
  }
}
