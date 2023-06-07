import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/LoginPage.dart';
import 'package:flutter_application_1/services/api_const.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<http.Response> register(String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(ApiConstants.baseURL + ApiConstants.register);
    http.Response response = await http.post(
      url,
      headers: ApiConstants.headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(ApiConstants.baseURL + ApiConstants.login);
    print(url);
    http.Response response = await http.post(
      url,
      headers: ApiConstants.headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static logOut(BuildContext context) {
    GetStorage().remove('user');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => route.settings.name == '/',
    );
  }
}
