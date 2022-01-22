import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

class EnterpriseInternshipProvider extends ChangeNotifier {
  final String _baseUrl = '10.0.2.2:3001';
  //final String _baseUrl = '192.168.56.1:3001';

  List<Internship> internshipsResponses = [];

  EnterpriseInternshipProvider() {
    getInternships();
  }

  Future<String> _getJsonData(String segment) async {
    var url = Uri.http(_baseUrl, segment);

    final response = await http.get(url);
    return response.body;
  }

  getInternships() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData =
        await _getJsonData('/internships/enterprise/${prefs.get('id2')}');

    final jsonDecoded = json.decode(jsonData);
    for (int i = 0; i < jsonDecoded['payload']['internship'].length; i++) {
      internshipsResponses
          .add(Internship.fromJson(jsonDecoded['payload']['internship'][i]));
    }

    notifyListeners();
  }
}
