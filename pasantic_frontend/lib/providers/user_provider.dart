import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  //static final String _baseUrl = '10.0.2.2:3001';
  static final String _baseUrl = '192.168.56.1:3001';

  static Future<String> getUserById(String id) async {
    var url = Uri.http(_baseUrl, '/users/$id');

    final response = await http.get(url);
    final jsonData = response.body;
    return jsonData;
  }

  static Future<String> getInsternshipsOfStudent(String idUser) async {
    var url = Uri.http(_baseUrl, '/students/$idUser');
    final response = await http.get(url);
    final jsonData = response.body;
    return jsonData;
  }
}
