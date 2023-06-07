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
        image: json['imageUrl'] ?? '');
  }

  Future getAllPosts() async {
    try {
      log('ы');
      final resp = await _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();
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
