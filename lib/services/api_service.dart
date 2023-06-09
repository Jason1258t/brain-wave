import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:brain_wave_2/utils/functoins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/models.dart';

class ApiService {
  final FirebaseFirestore _firestore;

  ApiService({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future getUserPostsById({required String userId, required bool type}) async {
    try {
      log('ы');
      final resp = await _firestore
          .collection('posts')
          //.orderBy('createdAt', descending: true)
          .where('creator_id', isEqualTo: userId)
          .get();
      final list =
          resp.docs.map((e) => {'data': e.data(), 'id': e.id}).toList();

      log(list.toString());

      final List<PostModel> posts = [];

      for (var i in list) {
        posts.add(await mapToPost(i, type));
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
      Map<String, dynamic> data = resp.data()!;
      data['uid'] = uid;
      log(data.toString());
      return data;
    } catch (e) {
      rethrow;
    }
  }
  String getCreatedTime(int ms) => AppFunctions.getTImeFromMs(ms);

  Future<PostModel> mapToPost(Map<String, dynamic> json, bool type) async {
    final user = await getUserById(json['data']['creator_id']);

    return PostModel(
        createdAt: getCreatedTime(json['data']['createdAt']),
        isOwner: type,
        id: json['id'],
        creatorName: user['firstName'],
        creatorId: json['data']['creator_id'],
        description: json['data']['description'],
        creatorImage: user['imageUrl'] ?? '',
        image: json['data']['imageUrl'] ?? '');
  }

  Future<NeuronModel> mapToNeuron(Map<String, dynamic> json, bool isLiked) async {
    try {
      List<String> tags = [];

      for (var i in json['data']['hashtag']) {
        try {
          tags.add(i);
        } catch (er) {}
      }

      return NeuronModel(
          name: json['data']['name'] ?? 'багануло',
          image: json['data']['imageUrl'] ?? '',
          isLike: isLiked,
          description: json['data']['description'],
          hashtag: tags);
    } catch (e) {
      rethrow;
    }

  }

  Future getAllPosts() async {
    try {
      log('ы');
      final resp = await _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();
      final list =
          resp.docs.map((e) => {'data': e.data(), 'id': e.id}).toList();

      log(list.toString());

      final List<PostModel> posts = [];

      for (var i in list) {
        posts.add(await mapToPost(i, false));
      }
      return posts;
    } catch (e) {
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

  Future createNeuron(
      {required String name,
        required String gitHub,
      required String uid,
      required File? image,
      required List<String> hashtag,
      required String description}) async {
    try {
      final doc = await _firestore.collection('neurons').add({
        'creator_id': uid,
        'name': name,
        'description': description,
        'imageUrl': '',
        'hashtag': hashtag,
        'github': gitHub,
      });

      if (image != null) {
        log(doc.path.toString());
        final postId = doc.path.split('/')[1];

        final imageUrl = await uploadImage(image, 'neuronImage_$postId.png');
        await _firestore.collection('posts').doc(postId).set(
          {'imageUrl': imageUrl},
          SetOptions(merge: true),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future loadAllNeurons() async {
    try {
      log('ы');
      final resp = await _firestore
          .collection('neurons')
          .get();
      final list =
      resp.docs.map((e) => {'data': e.data(), 'id': e.id}).toList();

      log(list.toString());

      final List<NeuronModel> posts = [];

      for (var i in list) {
        posts.add(await mapToNeuron(i, false));
      }

      for (var i in posts) {
        log(i.toString());
      }

      return posts;
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
          name: 'Chat gbt',
          image: 'Assets/chatGBT.png',
          isLike: true,
          description:
              'Чат-бот с искусственным интеллектом, разработанный компанией OpenAI и способный работать в диалоговом режиме, поддерживающий запросы на естественных языках. ChatGPT - большая языковая модель, для тренировки которой использовались методы обучения с учителем и обучения с подкреплением.',
          hashtag: ['генерация текста', 'asdfasdf', 'sadfs']),
    ];
  }

  Future getAllNeuron() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      NeuronModel(
          name: 'Chat GBT',
          image: 'Assets/chatGBT.png',
          isLike: true,
          hashtag: ['генерация текста', 'asdfasdf', 'sadfs'],
          description:
              'Чат-бот с искусственным интеллектом, разработанный компанией OpenAI и способный работать в диалоговом режиме, поддерживающий запросы на естественных языках. ChatGPT - большая языковая модель, для тренировки которой использовались методы обучения с учителем и обучения с подкреплением.'),
    ];
  }
}
