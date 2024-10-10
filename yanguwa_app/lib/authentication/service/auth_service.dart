import 'dart:io';

import 'package:yanguwa_app/authentication/model/user_model.dart';
import 'package:yanguwa_app/authentication/service/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const Map<String, String> header = {
  'Accept': 'application/json',
};

class AuthenticationService {
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    }) async {
      try {
        http.Response response = await http.post(
          Uri.parse(registerUrl),
          headers: header,
          body: {
            'name': name,
            'email': email,
            'password': password,
          },
        );

        if (response.statusCode != 200) {
          print("Register user: ${response.statusCode}");
          print("Register user: ${response.body}");
        }

        final UserModel userModel = userModelFromJson(response.body);
        return userModel;
      } on SocketException {
        debugPrint('No internet connection');
        rethrow;
      } catch (e) {
        debugPrint(e.toString());
        // rethrow;
        throw Exception(e.toString());
      }
    }

  //* Login Method

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(loginUrl),
        headers: header,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        print("Login user: ${response.statusCode}");
        print("Login user: ${response.body}");
      }

      final UserModel userModel = userModelFromJson(response.body);
      return userModel;
    } on SocketException {
      debugPrint('No internet connection');
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}