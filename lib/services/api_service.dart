import 'dart:async';

import 'package:brain_wave_2/models/neuron_model.dart';

import '../models/models.dart';

class ApiService {
  Future getUserPostsById({required String userId}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: '',
          image: 'Assets/openAi.png'),
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: '',
          image: 'Assets/openAi.png'),
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: '',
          image: 'Assets/openAi.png'),
    ];
  }

  Future getAllPosts() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: '',
          image: 'Assets/openAi.png'),
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: '',
          image: 'Assets/openAi.png'),
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: '',
          image: 'Assets/openAi.png'),
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: '',
          image: 'Assets/openAi.png'),
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: '',
          image: 'Assets/openAi.png'),
      PostModel(
          creatorName: 'лошара',
          description: 'очень классное описание ток здесь дап',
          title: 'топ 10 нейронок',
          creatorImage: '',
          image: 'Assets/openAi.png'),
    ];
  }

  Future NeuronById({required String Id}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      NeuronModel(
          title: 'Chat gbt',
          image: 'Assets/chatGBT.png',
          isLike: true,
          description:
              'Чат-бот с искусственным интеллектом, разработанный компанией OpenAI и способный работать в диалоговом режиме, поддерживающий запросы на естественных языках. ChatGPT - большая языковая модель, для тренировки которой использовались методы обучения с учителем и обучения с подкреплением.',
          hashtag: 'генерация текста'),
    ];
  }

  Future getAllNeuron() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      NeuronModel(
          title: 'Chat GBT',
          image: 'Assets/chatGBT.png',
          isLike: true,
          hashtag: 'генерация текста',
          description:
              'Чат-бот с искусственным интеллектом, разработанный компанией OpenAI и способный работать в диалоговом режиме, поддерживающий запросы на естественных языках. ChatGPT - большая языковая модель, для тренировки которой использовались методы обучения с учителем и обучения с подкреплением.'),
    ];
  }
}
