import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/admin_model.dart';
import '../screens/dashboard_screen.dart';
import '../screens/login_screen.dart';
import '../service/firestore_service.dart';

class AdminController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestore = FirestoreService();

  Admin? admin;
  bool isLoading = false;

  Future<void> login(String email, String password) async {
    try {
      isLoading = true;
      update();

      // First validate email format
      if (!email.isEmail) {
        throw 'Please enter a valid email address';
      }

      // Check password length
      if (password.length < 6) {
        throw 'Password must be at least 6 characters';
      }

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Add debug logging
      print('User authenticated: ${userCredential.user?.uid}');

      // Verify admin status
      final isAdmin = await _firestore.isAdmin(userCredential.user!.uid);
      print('Is admin: $isAdmin');

      if (isAdmin) {
        admin = Admin(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? 'Admin',
        );
        Get.offAll(() => DashboardScreen());
      } else {
        await _auth.signOut(); // Sign out non-admin users
        throw 'Access denied. This account is not authorized as an admin.';
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Authentication failed';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
      }
      Get.snackbar('Error', message);
    } catch (e) {
      print('Login error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> logout() async {
    try {
      isLoading = true;
      update(); // notify UI

      await _auth.signOut();
      admin = null;
      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    } finally {
      isLoading = false;
      update(); // notify UI
    }
  }
}
