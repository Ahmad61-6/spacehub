import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/auth/firebase_auth_service.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> createUser(UserModel user) async {
    try {
      await _firebaseService.firestore.collection('Users').doc(user.email).set({
        ...user.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUser(String email) async {
    try {
      final doc =
          await _firebaseService.firestore.collection('Users').doc(email).get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _firebaseService.firestore
          .collection('Users')
          .doc(user.email)
          .update(user.toMap());
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> addBooking(String email, Map<String, dynamic> booking) async {
    try {
      await _firebaseService.firestore.collection('Users').doc(email).update({
        'bookings': FieldValue.arrayUnion([booking])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadProfilePhoto(String userId, String filePath) async {
    try {
      final ref =
          _firebaseService.storage.ref().child('profile_photos').child(userId);
      await ref.putFile(filePath as File);
      return await ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
