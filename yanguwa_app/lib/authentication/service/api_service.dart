// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yanguwa_app/authentication/model/service.dart';

import '../model/service.dart';

Future<List<Service>> fetchServices() async {
  final response = await http.get(Uri.parse('https://yanguwa.edwincodes.tech/api/services'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((service) => Service.fromJson(service)).toList();
  } else {
    throw Exception('Failed to load services');
  }
}