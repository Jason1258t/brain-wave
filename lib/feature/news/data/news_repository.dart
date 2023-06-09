import 'dart:developer';

import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/models.dart';
import 'package:brain_wave_2/services/api_service.dart';
import 'package:rxdart/rxdart.dart';

class NewsRepository {
  final ApiService _apiService;

  NewsRepository({required ApiService apiService}) : _apiService = apiService;

  BehaviorSubject<LoadingStateEnum> newsState =
      BehaviorSubject<LoadingStateEnum>.seeded(LoadingStateEnum.wait);

  List<PostModel> _news = [];

  List<PostModel> getNews() => _news;

  void loadNews(bool f) async {
    if (f || _news.isEmpty) {
      newsState.add(LoadingStateEnum.loading);
      try {
        log('ы');
        final news = await _apiService.getAllPosts();
        _news = news;

        newsState.add(LoadingStateEnum.success);
      } catch (e) {
        newsState.add(LoadingStateEnum.fail);
      }
    }

  }
}
