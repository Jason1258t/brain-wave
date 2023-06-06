import 'dart:convert';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  List messages = [];


  BehaviorSubject<LoadingStateEnum> messageState = BehaviorSubject<LoadingStateEnum>.seeded(LoadingStateEnum.wait);

  Future<String> getMessageFromChatGBT(String question) async {
    messageState.add(LoadingStateEnum.loading);

    var url = Uri.parse("https://chatgpt53.p.rapidapi.com/");

    var payload = jsonEncode({
      "messages": [
        {
          "role": "user",
          "content": question
        }
      ],
      "temperature": 1
    });

    var headers = {
      "content-type": "application/json",
      "X-RapidAPI-Key": "5bcfeb6306msh0378fabcdbad24ep16d3f7jsn82c938e91912",
      "X-RapidAPI-Host": "chatgpt53.p.rapidapi.com"
    };

    var response = await http.post(url, body: payload, headers: headers);

    var responseBody = jsonDecode(response.body);
    var mes = responseBody['choices'][0]['message']['content'];

    messageState.add(LoadingStateEnum.success);

    return mes;
  }
}
