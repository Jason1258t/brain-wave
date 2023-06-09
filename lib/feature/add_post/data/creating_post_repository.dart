import 'dart:io';

import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/post_model.dart';
import 'package:brain_wave_2/services/api_service.dart';
import 'package:rxdart/rxdart.dart';

class PostCreatingRepository {
  final ApiService _apiService;

  PostCreatingRepository({required ApiService apiService})
      : _apiService = apiService;

  BehaviorSubject<LoadingStateEnum> creatingState =
      BehaviorSubject<LoadingStateEnum>.seeded(LoadingStateEnum.wait);

  void createPost(
      {required String title,
      required String description,
      required File? image,
      required String uid}) async {
    creatingState.add(LoadingStateEnum.loading);
    try {
      await _apiService.createPost(
          uid: uid, title: title, description: description, image: image);
      creatingState.add(LoadingStateEnum.success);
    } catch (e) {
      creatingState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }
}
