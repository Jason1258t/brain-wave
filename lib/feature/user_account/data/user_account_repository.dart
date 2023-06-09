import 'dart:developer';

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
  late List<PostModel> _userPosts;

  void loadUserById(String userId) async {
    log('хуй');
    userAccountState.add(LoadingStateEnum.loading);
    try {
      _user = await _apiService.getUserById(userId).then((value) => UserModel(
          uid: value['uid'],
          imageUrl: value['imageUrl'],
          name: value['firstName'],
          lastSeenInMs: value['lastSeen'].seconds * 1000));

      _userPosts = await _apiService.getUserPostsById(userId: _user.uid, type: false);
      userAccountState.add(LoadingStateEnum.success);
    } catch (e) {
      userAccountState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  UserModel getUser() => _user;
  List<PostModel> getPosts() => _userPosts;
}
