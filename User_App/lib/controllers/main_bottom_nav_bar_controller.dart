import 'package:get/get.dart';

class MainBottomNavBarController extends GetxController {
  int _selectedIndex = 0;
  int get currentIndex => _selectedIndex;

  void changeIndex(int index) {
    if (_selectedIndex == index) {
      return;
    }
    _selectedIndex = index;
    update();
  }

  void backToHome() {
    changeIndex(0);
  }

  void goToProfile() {
    changeIndex(3);
  }

  void goToSearch() {
    changeIndex(2);
  }
}
