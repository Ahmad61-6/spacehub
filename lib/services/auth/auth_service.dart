import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<UserCredential> signIn(
      {required String email, required String password});
  Future<UserCredential> createAccount(
      {required name, required email, required password});
  Future<void> signOut();
  Future<void> resetPassword({required email});
  Future<void> updateUserName({required String userName});
  Future<void> deleteAccount({required String email, required String password});
  Stream<User?> get authStateChanges;
  User? get currentUser;
}
