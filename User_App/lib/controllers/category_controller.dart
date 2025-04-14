import 'package:get/get.dart';

import '../core/models/work_space_model.dart';
import '../services/work_space_service.dart';

class CategoryController extends GetxController {
  late String _selectedCategory = 'private';
  List<Workspace> _workspaces = [];
  bool _isLoading = false;
  String? _error;

  String get selectedCategory => _selectedCategory;
  List<Workspace> get workspaces => _workspaces;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final WorkspaceService _workspaceService = WorkspaceService();

  @override
  void onInit() {
    super.onInit();
    loadWorkspaces(_selectedCategory);
  }

  Future<void> loadWorkspaces(String category) async {
    try {
      _isLoading = true;
      _error = null;
      update();

      _workspaces = await _workspaceService.getWorkspacesByCategory(category);
      _selectedCategory = category;

      print('Workspaces loaded successfully for category: $category');
    } catch (e) {
      _error = 'Failed to load workspaces';
      print('Error loading workspaces: $e');
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> refreshWorkspaces() async {
    await loadWorkspaces(_selectedCategory);
  }
}
