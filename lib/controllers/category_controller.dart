import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CategoryController extends GetxController {
  late String _selectedCategory = 'Private';
  final List<String> _currentItems = [];

  String get selectedCategory => _selectedCategory;

  List<String> get currentItems => _currentItems;

  final Map<String, List<String>> _categoryItems = {
    'Private': ['Bedroom', 'Bathroom', 'Living Room'],
    'Office': ['Desk', 'Chair', 'Meeting Room'],
    'Space': ['Garden', 'Balcony', 'Terrace'],
  };
  void selectCategory(String category) {
    _selectedCategory = category;
    _currentItems.clear();
    _currentItems.addAll(_categoryItems[category]!);
    update();
  }
}
