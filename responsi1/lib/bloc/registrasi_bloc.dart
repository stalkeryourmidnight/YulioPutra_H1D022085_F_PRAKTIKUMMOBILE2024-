import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:responsi1/helpers/api_url.dart';

class RegistrasiBloc {
  static Future<void> registrasi({
    required String nama,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.registrasi),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'nama': nama,
          'email': email,
          'password': password,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Registrasi berhasil');
        return;
      } else {
        print('Error: ${response.body}');
        throw Exception('Registrasi gagal');
      }
    } catch (e) {
      print('Error terjadi: $e');
      throw Exception('Gagal melakukan request');
    }
  }
}
