import 'dart:convert';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/message.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  List<Message> messages = [];
  final _dio = Dio();

  BehaviorSubject<LoadingStateEnum> messageState =
      BehaviorSubject<LoadingStateEnum>.seeded(LoadingStateEnum.wait);

  void addLoadingMessage() {
    messages.add(Message(
        isLoad: true,
        isReverse: true,
        text: '',
        authorName: 'Chat GPT',
        authorImage: '',
        createdAt: "${DateTime.now().hour}:${DateTime.now().minute}"));
  }

  void showLoadedMessage(String content) {
    messages[messages.length - 1] = Message(
        isReverse: true,
        text: content,
        isLoad: false,
        authorName: 'Chat GPT',
        authorImage: '',
        createdAt: "${DateTime.now().hour}:${DateTime.now().minute}");
  }

  Future<String> getMessageFromChatGBT(String question) async {
    addLoadingMessage();
    messageState.add(LoadingStateEnum.loading);

    final response = await _dio.post(
      "https://chatgpt53.p.rapidapi.com/",
      options: Options(headers: {
        "content-type": "application/json",
        "X-RapidAPI-Key": "5bcfeb6306msh0378fabcdbad24ep16d3f7jsn82c938e91912",
        "X-RapidAPI-Host": "chatgpt53.p.rapidapi.com"
      }),
      data: {
        "messages": [
          {"role": "user", "content": question}
        ],
        "temperature": 1
      },
    );

    final responseBody = response.data;
    final mes = responseBody['choices'][0]['message']['content'];
    showLoadedMessage(mes);

    messageState.add(LoadingStateEnum.success);

    return mes;
  }
}
