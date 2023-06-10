import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/services/api_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/models.dart';

class ProfileRepository {
  final ApiService _apiService;
  late String _userId;
  ProfileRepository({required ApiService apiService})
      : _apiService = apiService;

  BehaviorSubject<LoadingStateEnum> postsLoading =
  BehaviorSubject<LoadingStateEnum>.seeded(LoadingStateEnum.wait);
  List<PostModel> usersPosts = [];


  void setUserId(String userId) {
    _userId = userId;
  }

  void initialLoadPosts({bool f = false}) async {
    if (usersPosts.isEmpty || f) {
      postsLoading.add(LoadingStateEnum.loading);
      try {
        final posts = await _apiService.getUserPostsById(userId: _userId, type: true);
        usersPosts = posts;
        postsLoading.add(LoadingStateEnum.success);
      } catch (e) {
        postsLoading.add(LoadingStateEnum.fail);
      }
    }
  }

  void deletePost(PostModel postModel) async {
    try {
      _apiService.deletePost(postId: postModel.id);
      initialLoadPosts(f: true);
    } catch (e) {
      rethrow;
    }
  }
}