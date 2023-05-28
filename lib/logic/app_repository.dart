import 'package:brain_wave_2/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppStateEnum { auth, unAuth, start }

enum AuthStateEnum { loading, logged, registered, fail, wait }

class AppRepository {
  final FirebaseAuthService _firebaseAuthService;
  late AuthData authData;

  AppRepository({required FirebaseAuthService firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService;
  BehaviorSubject<AppStateEnum> appState =
      BehaviorSubject<AppStateEnum>.seeded(AppStateEnum.start);
  BehaviorSubject<AuthStateEnum> authState =
      BehaviorSubject<AuthStateEnum>.seeded(AuthStateEnum.wait);

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    appState.add(AppStateEnum.unAuth);
    authState.add(AuthStateEnum.wait);
  }

  void checkLogin() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final userId = prefs.getString('uid');
      if (userId == null) {
        appState.add(AppStateEnum.unAuth);
      } else {
        loadSavedData().then((value) => loadSavedData());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future loadSavedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid');
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    try {
      final user =
          _firebaseAuthService.sighInWithEmailAndPassword(email!, password!);
      authData = AuthData(userId: uid!.toString(), email: email);
      appState.add(AppStateEnum.auth);
    } catch (e) {
      appState.add(AppStateEnum.unAuth);
    }
  }

  Future saveAuthData(String email, String uid, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  void firebaseLoginUserWithEmailAndPassword(
      String email, String password) async {
    authState.add(AuthStateEnum.loading);
    try {
      final User user = await _firebaseAuthService.sighInWithEmailAndPassword(
          email, password);
      authData = AuthData(userId: user.uid, email: email);
      saveAuthData(email, user.uid, password);
      authState.add(AuthStateEnum.logged);
      appState.add(AppStateEnum.auth);
    } catch (e) {
      rethrow;
    }
  }
}

class AuthData {
  final String userId;
  final String email;

  //final String password;

  AuthData({required this.userId, required this.email});
}
