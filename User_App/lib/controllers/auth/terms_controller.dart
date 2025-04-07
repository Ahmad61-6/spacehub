import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TermsController extends GetxController {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void toggleCheckbox(bool? value) {
    _isChecked = value ?? !_isChecked;
    update();
  }
}
