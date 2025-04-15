import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../services/auth/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<UserCredential> signUpWithEmail(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _firebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      return await _firebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _firebaseService.auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseService.auth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseService.auth.currentUser;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseService.auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }
}
