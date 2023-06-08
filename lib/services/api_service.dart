import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/models.dart';

class ApiService {
  final FirebaseFirestore _firestore;

  ApiService({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future getUserPostsById({required String userId}) async {
    try {
      log('ы');
      final resp = await _firestore
          .collection('posts')
          //.orderBy('createdAt', descending: true)
          .where('creator_id', isEqualTo: userId)

          .get();
      final list = resp.docs.map((e) => {'data': e.data(), 'id': e.id}).toList();

      log(list.toString());

      final List<PostModel> posts = [];

      for (var i in list) {
        posts.add(await mapToPost(i, true));
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

  String? getMonthName(int month) {
    switch (month) {
      case 1: return 'января';
      case 2: return 'февраля';
      case 3: return 'марта';
      case 4: return 'апреля';
      case 5: return 'мая';
      case 6: return 'июня';
      case 7: return 'июля';
      case 8: return 'августа';
      case 9: return 'сентября';
      case 10: return 'октября';
      case 11: return 'ноября';
      case 12: return 'декабря';
    }
    return null;
  }


  String getCreatedTime(int ms) {
    final currentDate = DateTime.now();
    final gotDate = DateTime.fromMillisecondsSinceEpoch(ms);
    String pref;
    if (currentDate.difference(gotDate).inDays == 1) {
      pref = 'вчера';
    } else if (currentDate.difference(gotDate).inDays == 0) {
      pref = 'сегодня';
    } else {
      pref = '${gotDate.day} ${getMonthName(gotDate.month)}';
    }

    final hour = gotDate.hour;
    final minute = gotDate.minute;

    return '$pref $hour:${minute > 9 ? minute : "0$minute"}';
  }

  Future<PostModel> mapToPost(Map<String, dynamic> json, bool type) async {
    final user = await getUserById(json['data']['creator_id']);

    return PostModel(
      createdAt: getCreatedTime(json['data']['createdAt']),
        isOwner: type,
        id: json['id'],
        creatorName: user['firstName'],
        description: json['data']['description'],
        creatorImage: user['imageUrl'] ?? '',
        image: json['data']['imageUrl'] ?? '');
  }

  Future getAllPosts() async {
    try {
      log('ы');
      final resp = await _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();
      final list = resp.docs.map((e) => {'data': e.data(), 'id': e.id}).toList();

      log(list.toString());

      final List<PostModel> posts = [];

      for (var i in list) {
        posts.add(await mapToPost(i, false));
      }
      return posts;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future deletePost({required String postId}) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      rethrow;
    }

  }

  Future createPost(
      {required String uid,
      required String title,
      required String description,
      required File? image}) async {
    try {
      final doc = await _firestore.collection('posts').add({
        'creator_id': uid,
        'title': title,
        'description': description,
        'imageUrl': '',
        'createdAt': DateTime.now().millisecondsSinceEpoch
      });

      if (image != null) {
        log(doc.path.toString());
        final postId = doc.path.split('/')[1];

        final imageUrl = await uploadImage(image, 'postImage_$postId.png');
        await _firestore.collection('posts').doc(postId).set(
          {'imageUrl': imageUrl},
          SetOptions(merge: true),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future uploadImage(File file, String imageId) async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainImagesRef = storageRef.child("images/$imageId");

    try {
      await mountainImagesRef.putFile(file);
      final downloadUrl = mountainImagesRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future neuronById({required String Id}) async {
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
