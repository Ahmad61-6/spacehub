import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String uid;
  final String email;
  final String name;

  Admin({required this.uid, required this.email, required this.name});

  factory Admin.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Admin(
      uid: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? 'Admin',
    );
  }
}
