import 'package:firebase_auth/firebase_auth.dart';
import 'package:spacehub/services/auth/auth_service.dart';

class FirebaseAuthService extends AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  Future<UserCredential> createAccount(
      {required name, required email, required password}) async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> deleteAccount(
      {required String email, required String password}) async {}

  @override
  Future<void> resetPassword({required email}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signIn(
      {required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserName({required String userName}) {
    // TODO: implement updateUserName
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentUser
  User? get currentUser => firebaseAuth.currentUser;
}
