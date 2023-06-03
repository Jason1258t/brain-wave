import 'dart:async';

import 'package:brain_wave_2/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

enum AppStateEnum { auth, unAuth, start }

enum AuthStateEnum { loading, logged, registered, fail, wait }

class AppRepository {
  final FirebaseAuthService _firebaseAuthService;
  late User _user;
  late StreamSubscription _userUpdateState;

  AppRepository({required FirebaseAuthService firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService;
  BehaviorSubject<AppStateEnum> appState =
  BehaviorSubject<AppStateEnum>.seeded(AppStateEnum.start);
  BehaviorSubject<AuthStateEnum> authState =
  BehaviorSubject<AuthStateEnum>.seeded(AuthStateEnum.wait);

  void logout() async {
    await _firebaseAuthService.logout();
    appState.add(AppStateEnum.unAuth);
    authState.add(AuthStateEnum.wait);
  }

  User getCurrentUser() => _user;

  void updateUser() async {
    _userUpdateState =
        _firebaseAuthService.userUpdateState.stream.listen((event) {
          if (event != null) _user = event;
        });
  }

  void checkLogin() async {
    try {
      final user = await _firebaseAuthService.checkLoginWithFirebase();
      final userId = user.uid;
      if (userId == null) {
        _user = user;
        appState.add(AppStateEnum.unAuth);
      } else {
        loadSavedData().then((value) => loadSavedData());
      }
    } catch (e) {
      appState.add(AppStateEnum.unAuth);
      rethrow;
    }
  }

  Future loadSavedData() async {
    try {
      final user = await _firebaseAuthService.checkLoginWithFirebase();
      if (user != null) {
        _user = user;
        appState.add(AppStateEnum.auth);
      } else {
        appState.add(AppStateEnum.unAuth);
      }
    } catch (e) {
      appState.add(AppStateEnum.unAuth);
    }
  }

  void firebaseLoginUserWithEmailAndPassword(String email,
      String password) async {
    authState.add(AuthStateEnum.loading);
    try {
      final User user = await _firebaseAuthService.sighInWithEmailAndPassword(
          email, password);
      _user = user;
      authState.add(AuthStateEnum.logged);
      appState.add(AppStateEnum.auth);
    } catch (e) {
      rethrow;
    }
  }

  void firebaseLoginWithGoogle() async {
    authState.add(AuthStateEnum.loading);
    try {
      final User user = await _firebaseAuthService.signInWithGoogle();
      _user = user;
      authState.add(AuthStateEnum.logged);
      appState.add(AppStateEnum.auth);
    } catch (e) {
      authState.add(AuthStateEnum.fail);
      rethrow;
    }
  }

  void firebaseRegisterUserWithEmailAndPassword(String email, String password,
      String name) async {
    authState.add(AuthStateEnum.loading);
    try {
      final User user = await _firebaseAuthService.registerWithEmailAndPassword(
          email, password, name);
      _user = user;
      authState.add(AuthStateEnum.registered);
      appState.add(AppStateEnum.auth);
    } catch (e) {
      rethrow;
    }
  }

  void completeRegistration() {
    appState.add(AppStateEnum.auth);
  }
}
