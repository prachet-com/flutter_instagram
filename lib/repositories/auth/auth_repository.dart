import 'package:flutter/services.dart';
import 'package:flutter_instagram/config/Paths.dart';
import 'package:flutter_instagram/models/failure_model.dart';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_instagram/repositories/auth/base_auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({
    FirebaseFirestore firebaseFirestore,
    auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<auth.User> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User> signupWithEmailAndPassword({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      _firebaseFirestore.collection(Paths.users).doc(user.uid).set({
        'username': username,
        'email': email,
        'followers': 0,
        'following': 0
      });
      return user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message);
    }
  }

  @override
  Future<auth.User> loginWithUsernameAndPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message);
    }
  }

  @override
  Future<auth.User> googleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message);
    } on PlatformException catch (err) {
      print('Platform exception error '
          '----------------------------------------------------->');
      print('err.code ------>');
      print(err.code);
      print('err.message ------>');
      print(err.message);
      print('err.details ------>');
      print(err.details);
      print('err.stacktrace ------>');
      print(err.stacktrace);
      throw Failure(code: err.code, message: err.message);
    }
  }

  @override
  Future<auth.User> signInAnonymously() async {
    try {
      final credential = await _firebaseAuth.signInAnonymously();
      return credential.user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message);
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
