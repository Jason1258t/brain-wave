import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  BehaviorSubject<User?> userUpdateState = BehaviorSubject<User?>.seeded(null);

  FirebaseAuthService() : super() {
    subscribeUserChanges();
  }

  User? currentUser() => _firebaseAuth.currentUser;

  void subscribeUserChanges() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null) {
        print('');
        print('');
        print('');
        print('');
        print('');
        print(user.toString());
        print('');
        print('');
        print('');
        print('');
        print('');
      }
    });
  }

  void updater() async {
    int endIn = 120;
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (endIn > 0) {
        _firebaseAuth.currentUser?.reload();
        if (_firebaseAuth.currentUser!.emailVerified) timer.cancel();
        endIn--;
      } else {
        timer.cancel();
      }
    });
  }

  Future verifyEmail() async {
    await _firebaseAuth.currentUser?.sendEmailVerification().whenComplete(() => updater());
  }

  Future changeName(String name) async {
    try {
      await _firebaseAuth.currentUser?.updateDisplayName(name);
    } catch (e) {
      rethrow;
    }

  }

  Future checkLoginWithFirebase() async {
    try {
      final user = _firebaseAuth.currentUser;
      await user!.reload();
      return user;
    } catch (e) {
      log('ошибка повторной авторизации с firebase $e');
      return null;
    }
  }

  Future logout() async {
    await _firebaseAuth.signOut();
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final response = await _firebaseAuth.signInWithCredential(credential);
      final user = response.user;
      log('---------------------------------------------');
      log('-                                           -');
      log('-                                           -');
      log('-                                           -');
      log(user!.uid.toString());
      log(user.email.toString());
      log(user.displayName.toString());
      log(user.photoURL.toString());
      log('-                                           -');
      log('-                                           -');
      log('-                                           -');
      log('---------------------------------------------');
      return user;
    } catch (e) {
      rethrow;
    }
    // Trigger the authentication flow
  }

  Future sighInWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = response.user;
      log('---------------------------------------------');
      log('-                                           -');
      log('-                                           -');
      log('-                                           -');
      log(user!.uid.toString());
      log(user.email.toString());
      log(user.displayName.toString());
      log(user.photoURL.toString());
      log('-                                           -');
      log('-                                           -');
      log('-                                           -');
      log('---------------------------------------------');

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateDisplayName(name);

      final user = _firebaseAuth.currentUser;
      log('---------------------------------------------');
      log('-                                           -');
      log('-                                           -');
      log('-                                           -');
      log(user!.uid.toString());
      log(user.email.toString());
      log(user.displayName.toString());
      log(user.photoURL.toString());
      log('-                                           -');
      log('-                                           -');
      log('-                                           -');
      log('---------------------------------------------');

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
