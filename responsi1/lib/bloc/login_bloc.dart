import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi1/helpers/api_url.dart';
import 'package:responsi1/model/login.dart'; 

class LoginBloc {
  static Future<Login> login({
    required String email,
    required String password,
  }) async {
    var body = {
      'email': email,
      'password': password,  
    };

    try {
      final response = await http.post(
        Uri.parse(ApiUrl.login),
        headers: {
          'Content-Type': 'application/json', 
        },
        body: json.encode(body), 
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return Login.fromJson(jsonResponse);
      } else {
        throw Exception('Login gagal: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi error saat login: $e');
    }
  }
}
