import 'dart:async';

import '../models/models.dart';

class ApiService {
  Future getUserPostsById({required String userId}) async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: 'Assets/ProfileImage.png',
          image: 'Assets/openAi.png'),
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: 'Assets/ProfileImage.png',
          image: 'Assets/openAi.png'),
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: 'Assets/ProfileImage.png',
          image: 'Assets/openAi.png'),
    ];
  }
}
