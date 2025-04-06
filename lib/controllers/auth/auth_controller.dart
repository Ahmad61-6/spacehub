import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacehub/view/screens/main_bottom_nav_bar.dart';

import '../../core/models/user_model.dart';
import '../../core/repositories/auth_repository.dart';
import '../../core/repositories/user_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  bool isLoading = false;
  UserModel? user;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }

  Future<void> signUpWithEmail(
      String email, String password, String name) async {
    try {
      setLoading(true);
      final userCredential =
          await _authRepository.signUpWithEmail(email, password, name);

      final newUser = UserModel(
        id: userCredential.user?.uid,
        name: name,
        email: email,
      );

      await _userRepository.createUser(newUser);
      user = newUser;
      update();
      Get.offAll(() => MainBottomNavBar());
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(_getErrorMessage(e));
    } catch (e) {
      _showErrorSnackbar('An unexpected error occurred. Please try again.');
    } finally {
      setLoading(false);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      setLoading(true);
      await _authRepository.signInWithEmail(email, password);
      user = await _userRepository.getUser(email);
      update();
      Get.offAll(() => MainBottomNavBar());
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(_getErrorMessage(e));
    } catch (e) {
      _showErrorSnackbar('An unexpected error occurred. Please try again.');
    } finally {
      setLoading(false);
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  // Update social login methods to use snackbar
  Future<void> signInWithGoogle() async {
    try {
      setLoading(true);
      final userCredential = await _authRepository.signInWithGoogle();

      var existingUser =
          await _userRepository.getUser(userCredential.user!.email!);

      if (existingUser == null) {
        final newUser = UserModel(
          id: userCredential.user?.uid,
          name: userCredential.user?.displayName ?? 'No Name',
          email: userCredential.user?.email ?? '',
          profilePhoto: userCredential.user?.photoURL,
        );

        await _userRepository.createUser(newUser);
        user = newUser;
      } else {
        user = existingUser;
      }
      update();
      Get.offAll(() => MainBottomNavBar());
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar('Google sign in failed: ${e.message}');
    } catch (e) {
      _showErrorSnackbar('Google sign in failed. Please try again.');
    } finally {
      setLoading(false);
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    user = null;
    update();
  }

  Future<void> fetchUserData() async {
    final currentUser = _authRepository.getCurrentUser();
    if (currentUser != null && currentUser.email != null) {
      user = await _userRepository.getUser(currentUser.email!);
      update();
    }
  }

// Similarly update signInWithFacebook and signInWithTwitter methods
// ...
}
