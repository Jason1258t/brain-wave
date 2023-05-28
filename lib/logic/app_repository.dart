import 'package:brain_wave_2/services/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppStateEnum { auth, unAuth, start }

enum AuthStateEnum { loading, logged, registered, fail, wait }

class AppRepository {
  final FirebaseAuthService _firebaseAuthService;

  AppRepository({required FirebaseAuthService firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService;
  BehaviorSubject<AppStateEnum> appState =
      BehaviorSubject<AppStateEnum>.seeded(AppStateEnum.start);
  BehaviorSubject<AuthStateEnum> authState =
      BehaviorSubject<AuthStateEnum>.seeded(AuthStateEnum.wait);

  void checkLogin() async {
    try {
      final SharedPreferences  prefs = await SharedPreferences.getInstance();

      final userId = prefs.getInt('id');
      if (userId == null) {
        appState.add(AppStateEnum.unAuth);
      } else {
        loadSavedData().then((value) => appState.add(AppStateEnum.auth));
      }
    } catch (e) {
      rethrow;
    }
  }


  Future loadSavedData() async {
    
  }


  void firebaseLoginUserWithEmailAndPassword(
      String email, String password) async {
    final user =
        await _firebaseAuthService.sighInWithEmailAndPassword(email, password);
  }
}



