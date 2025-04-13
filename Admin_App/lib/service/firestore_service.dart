import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/work_space_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addWorkspace(Workspace workspace) async {
    final docRef = await _firestore
        .collection('workspaces')
        .add(workspace.toFirestore());
    return docRef.id;
  }

  Future<void> updateWorkspace(Workspace workspace) async {
    await _firestore
        .collection('workspaces')
        .doc(workspace.id)
        .update(workspace.toFirestore());
  }

  Future<void> deleteWorkspace(String id) async {
    await _firestore.collection('workspaces').doc(id).delete();
  }

  Stream<List<Workspace>> getWorkspaces() {
    return _firestore
        .collection('workspaces')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Workspace.fromFirestore(doc)).toList(),
        );
  }

  // Admin Authentication
  Future<bool> isAdmin(String uid) async {
    try {
      final doc = await _firestore.collection('admins').doc(uid).get();
      return doc.exists;
    } catch (e) {
      print('Error checking admin status: $e');
      return false;
    }
  }
}
