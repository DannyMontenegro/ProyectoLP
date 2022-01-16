import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class InternshipsProvider extends ChangeNotifier {
  final String _baseUrl = '10.0.2.2:3001';

  List<Internship> internshipsResponses = [];

  int _internshipsPage = 0;
  final int _limitPage = 10;

  InternshipsProvider() {
    getInternships();
  }

  Future<String> _getJsonData(String segment, [int page = 1]) async {
    var url =
        Uri.http(_baseUrl, segment, {'page': '$page', 'limit': '$_limitPage'});

    final response = await http.get(url);
    return response.body;
  }

  getInternships() async {
    _internshipsPage += 1;
    final jsonData = await _getJsonData('/internships');
    final jsonDecoded = json.decode(jsonData);

    for (int i = 0; i < jsonDecoded['payload'].length; i++) {
      internshipsResponses.add(Internship.fromJson(jsonDecoded['payload'][i]));
    }

    notifyListeners();
  }
}
