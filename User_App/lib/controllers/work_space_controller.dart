import 'package:get/get.dart';

import '../core/models/work_space_model.dart';
import '../services/work_space_service.dart';

class WorkspaceController extends GetxController {
  final WorkspaceService _workspaceService = WorkspaceService();

  List<Workspace> workspaces = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchAllWorkspaces() async {
    isLoading = true;
    error = null;
    update();

    try {
      workspaces = await _workspaceService.getAllWorkspaces();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> refreshWorkspaces() async {
    await fetchAllWorkspaces();
  }
}
