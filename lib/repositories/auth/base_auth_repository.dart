import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Stream<auth.User> get user;

  Future<auth.User> signupWithEmailAndPassword({
    String username,
    String email,
    String password,
  });

  Future<auth.User> loginWithUsernameAndPassword({
    String email,
    String password,
  });

  Future<auth.User> googleSignIn();

  Future<auth.User> signInAnonymously();

  Future<void> logout();
}
