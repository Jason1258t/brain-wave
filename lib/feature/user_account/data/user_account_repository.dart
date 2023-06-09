import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/models.dart';
import 'package:brain_wave_2/services/api_service.dart';
import 'package:rxdart/rxdart.dart';

class UserAccountRepository {
  final ApiService _apiService;

  UserAccountRepository({required ApiService apiService})
      : _apiService = apiService;

  BehaviorSubject<LoadingStateEnum> userAccountState =
      BehaviorSubject<LoadingStateEnum>.seeded(LoadingStateEnum.wait);

  late UserModel _user;

  void loadUserById(String userId) async {
    userAccountState.add(LoadingStateEnum.loading);
    try {
      final user = await _apiService.getUserById(userId);
      _user = UserModel(
          uid: user['uid'],
          imageUrl: user['imageUrl'],
          name: user['firstName']);
      userAccountState.add(LoadingStateEnum.success);
    } catch (e) {
      userAccountState.add(LoadingStateEnum.fail);
    }
  }

  UserModel getUser() => _user;
}
