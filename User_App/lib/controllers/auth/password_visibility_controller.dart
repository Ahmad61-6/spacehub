import 'package:get/get.dart';

class PasswordVisibilityController extends GetxController {
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    update();
  }
}
