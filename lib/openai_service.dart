import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mr_gk/secret.dart';

class OpenAIService{
  Future<String>isArtPromtAPI(String promt) async{
    try {
      final res = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
                 'Content-Type': 'application/json',
                 'Authorization': 'Bearer $openAIAPIKey'
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
      {
        'role': 'user',
        'content':'Does this message want to generate an AI picture, image, art or anything similar? $promt . Simply answer with a yes or no.',
      }
          ]
        }
      ));
      print(res.body);
      if (res.statusCode == 200) {
        String content = 
        jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        switch(content){
          case 'yes':
          case 'Yes':
          case 'Yes.':
          case 'yes.':
          final res = dallEAPI(promt);
           return res;
           default:
           final res = chatGPTAPI(promt);
           return res;

        }
      }
      return 'An internal error occured';
    } catch (e) {
      return  e.toString();
    }
  }
  Future<String>chatGPTAPI(String promt) async{
    return 'CHATGPT';
  }
  Future<String>dallEAPI(String promt) async{
    return 'DALL-E';
  }
}