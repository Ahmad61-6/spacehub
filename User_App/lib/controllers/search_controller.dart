// controllers/search_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:spacehub/core/models/work_space_model.dart';

import '../services/work_space_service.dart';

class SearchScreenController extends GetxController {
  final WorkspaceService _workspaceService = WorkspaceService();

  List<Workspace> _searchResults = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Workspace> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  Future<void> searchWorkspaces(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      update();
      return;
    }

    _searchQuery = query;
    _isLoading = true;
    update();

    try {
      // Search by name (case insensitive)
      final snapshot = await FirebaseFirestore.instance
          .collection('workspaces')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .limit(10)
          .get();

      _searchResults =
          snapshot.docs.map((doc) => Workspace.fromFirestore(doc)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to search workspaces: ${e.toString()}');
    } finally {
      _isLoading = false;
      update();
    }
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    update();
  }
}
