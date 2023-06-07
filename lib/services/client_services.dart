import 'dart:convert';
import 'dart:ui';

import 'package:flutter_application_1/services/api_const.dart';
import 'package:flutter_application_1/services/callapi.dart';
import 'package:http/http.dart' as http;

import '../model/client.dart';

class ClientServices {
  static Future<List<Client>> getClients() async {
    try {
      var url = Uri.parse(ApiConstants.baseURL + ApiConstants.clients);
      http.Response response = await http.get(
        url,
        headers: ApiConstants.headers,
      );
      var jsondata = jsonDecode(response.body);
      List<Client> clients = [];

      for (var data in jsondata['clients']) {
        clients.add(Client.fromJson(data as Map<String, dynamic>));
      }

      return clients;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future updateClient(int id, String name, String tel, String email) async {
    try {
      Map<String, dynamic> data = {
        "name": name,
        "tel": tel,
        "email": email,
      };
      http.Response response = await CallApi().putData(data, ApiConstants.client + "/${id}");
    } catch (e) {
      print(e.toString());
    }
  }

  static Future addClient(String name, String tel, String email, String adress) async {
    try {
      Map<String, dynamic> data = {
        "name": name,
        "tel": tel,
        "email": email,
        "adress": adress,
      };
      http.Response response = await CallApi().postData(data, ApiConstants.client);
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }

  static deleteClient(int id, VoidCallback refresh) async {
    try {
      dynamic response = CallApi().deleteData(ApiConstants.client + "/${id}");
      refresh();
    } catch (e) {
      print(e.toString());
    }
  }
}
