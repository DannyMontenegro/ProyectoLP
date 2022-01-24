// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApplicationsProvider extends ChangeNotifier {
  final String _baseUrl = '10.0.2.2:3001';
  //final String _baseUrl = '192.168.56.1:3001';

  List<Internship> internshipsResponses = [];

  ApplicationsProvider() {
    print("Iniciando Applications Provider");
  }

  Future<String> _getJsonData(String segment) async {
    var url = Uri.http(_baseUrl, segment);

    final response = await http.get(url);
    return response.body;
  }

  getInternships(String id) async {
    final jsonData = await _getJsonData('/internships/$id');
    final jsonDecoded = json.decode(jsonData);
    print(jsonDecoded);
    // for (int i = 0; i < jsonDecoded['payload'].length; i++) {
    //   internshipsResponses.add(Internship.fromJson(jsonDecoded['payload'][i]));
    // }

    notifyListeners();
  }
}
