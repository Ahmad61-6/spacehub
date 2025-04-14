import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/models/work_space_model.dart';

class WorkspaceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Workspace>> getWorkspacesByCategory(String category) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('workspaces')
          .where('category', isEqualTo: category.toLowerCase())
          .get();

      List<Workspace> workspaces = querySnapshot.docs
          .map((doc) => Workspace.fromFirestore(doc))
          .toList();

      print('Fetched ${workspaces.length} ${category} workspaces');
      print('${workspaces}');
      return workspaces;
    } catch (e) {
      print('Error fetching $category workspaces: ${e.toString()}');
      throw Exception('Failed to load $category workspaces');
    }
  }

  Future<List<Workspace>> getAllWorkspaces() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('workspaces').get();

      List<Workspace> workspaces = querySnapshot.docs
          .map((doc) => Workspace.fromFirestore(doc))
          .toList();

      print('Successfully fetched ${workspaces.length} workspaces');
      return workspaces;
    } catch (e) {
      print('Error fetching all workspaces: $e');
      throw Exception('Failed to load workspaces');
    }
  }
}
