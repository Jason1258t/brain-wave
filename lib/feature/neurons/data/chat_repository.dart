import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatRepository {
  Future<String> getChat(String question) async {
    var url = Uri.parse("https://chatgpt53.p.rapidapi.com/");

    var payload = jsonEncode({
      "messages": [
        {
          "role": "user",
          "content": "hi how are you?"
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

    return mes;
  }
}
