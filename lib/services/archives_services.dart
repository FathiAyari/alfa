import 'dart:convert';

import 'package:flutter_application_1/services/api_const.dart';
import 'package:flutter_application_1/services/callapi.dart';
import 'package:http/http.dart' as http;

class ArchivesServices {
  static Future<Map<String, dynamic>> getSales() async {
    try {
      http.Response response = await CallApi().getData(ApiConstants.pdf);
      return jsonDecode(response.body);
    } catch (e) {
      return {};
    }
  }
}
