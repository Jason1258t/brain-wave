import 'dart:async';
import 'dart:developer';

import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class ApiService {
  final FirebaseFirestore _firestore;

  ApiService({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future getUserPostsById({required String userId}) async {
    try {
      log('ы');
      final resp = await _firestore.collection('posts').where('creator_id', isEqualTo: userId).get();
      final list = resp.docs.map((e) => e.data()).toList();

      log(list.toString());

      final List<PostModel> posts = [];

      for (var i in list) {
        posts.add(await mapToPost(i));
      }
      return posts;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  Future getUserById(String uid) async {
    try {
      final resp = await _firestore.collection('users').doc(uid).get();
      //log(resp.data().toString());
      return resp.data();
    } catch (e) {
      rethrow;
    }
  }
  
  Future<PostModel> mapToPost(Map<String, dynamic> json) async {
    final user = await getUserById(json['creator_id']);

    return PostModel(
        creatorName: user['firstName'],
        description: json['description'],
        title: json['title'],
        creatorImage: user['imageUrl'] ?? '',
        image: 'Assets/openAi.png');
  }

  Future getAllPosts() async {
    try {
      log('ы');
      final resp = await _firestore.collection('posts').get();
      final list = resp.docs.map((e) => e.data()).toList();

      log(list.toString());

      final List<PostModel> posts = [];

      for (var i in list) {
        posts.add(await mapToPost(i));
      }
      return posts;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future createPost({required String uid, required String title, required String description}) async {
    try {
      await _firestore.collection('posts').add({
        'creator_id': uid,
        'title': title,
        'description': description,
        'imageUrl': ''
      });
      

    } catch (e) {
      rethrow;
    }
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
