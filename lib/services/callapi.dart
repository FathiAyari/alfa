import 'dart:convert';

import 'package:flutter_application_1/services/api_const.dart';
import 'package:http/http.dart' as http;

class CallApi {
  postData(data, apiUrl) async {
    var fullUrl = ApiConstants.baseURL + apiUrl;
    return await http.post(Uri.parse(fullUrl), body: jsonEncode(data), headers: _setHeaders());
  }

  putData(data, apiUrl) async {
    var fullUrl = ApiConstants.baseURL + apiUrl;
    return await http.put(Uri.parse(fullUrl), body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = ApiConstants.baseURL + apiUrl;
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  deleteData(apiUrl) async {
    var fullUrl = ApiConstants.baseURL + apiUrl;
    return await http.delete(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Connection": "Keep-Alive",
      };
}
