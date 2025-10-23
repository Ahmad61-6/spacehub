import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacehub/view/screens/main_bottom_nav_bar.dart';

import '../../core/models/user_model.dart';
import '../../core/repositories/auth_repository.dart';
import '../../core/repositories/user_repository.dart';
import '../../view/screens/auth/forgot_password/password_recovery_confirmation_screen.dart';
import '../../view/screens/auth/login_screen.dart';
import '../user_controller.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();
  bool isLoading = false;
  UserModel? user;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  void updateUser(UserModel updatedUser) {
    user = updatedUser;
    update(); // Notifies GetBuilder to rebuild widgets
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'error',
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', email);

      await _userRepository.createUser(newUser);
      user = newUser;
      print(user.toString());
      update();
      Get.offAll(() => MainBottomNavBar());
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(_getErrorMessage(e));
    } catch (e) {
      _showErrorSnackbar('An unexpected error occurred. Please try again..');
    } finally {
      setLoading(false);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      setLoading(true);
      await _authRepository.signInWithEmail(email, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', email);
      user = await _userRepository.getUser(email);
      update();
      Get.offAll(() => MainBottomNavBar());
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(_getErrorMessage(e));
    } catch (e) {
      _showErrorSnackbar('An unexpected error occurred. Please try again.');
      debugPrint("___----____ >>> Error in signInWithEmail: $e");
    } finally {
      setLoading(false);
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted!';
      case 'user-disabled':
        return 'This user has been disabled!';
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', userCredential.user!.email!);
      update();
      Get.offAll(() => MainBottomNavBar());
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar('Google sign in failed: ${e.message}');
      debugPrint("___----____ >>> Error in signInWithGoogle: $e");
    } catch (e) {
      _showErrorSnackbar('Google sign in failed. Please try again.');
      debugPrint("___----____ >>> Error in signInWithGoogle: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      setLoading(true);
      update();

      // 1. Sign out from Firebase Authentication
      await _authRepository.signOut();

      // 2. Clear local preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userEmail');

      // 3. Clear local state
      user = null;
      update();

      // 4. Navigate to login screen
      Get.offAll(() => LoginScreen());
    } catch (e) {
      _showErrorSnackbar('Failed to sign out: ${e.toString()}');
    } finally {
      setLoading(false);
      update();
    }
  }

  Future<void> fetchUserData(String email) async {
    try {
      isLoading = true;
      update();

      user = await _userRepository.getUser(email);
      Get.find<UserController>().user = user;
      Get.find<UserController>().update();

      // Save email to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', email);

      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      setLoading(true);
      await _authRepository.sendPasswordResetEmail(email);
      Get.off(() => PasswordRecoveryConfirmationScreen(
          email: email)); // Replace current screen
      Get.snackbar(
        'Success',
        'Password reset email sent to $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 1), // Show for 4 seconds
      );
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(_getErrorMessage(e));
    } catch (e) {
      _showErrorSnackbar('Failed to send reset email. Please try again.');
    } finally {
      setLoading(false);
    }
  }
}
