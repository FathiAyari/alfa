import 'dart:convert';
import 'dart:ui';

import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/services/api_const.dart';
import 'package:flutter_application_1/services/callapi.dart';
import 'package:http/http.dart' as http;

class StockServices {
  static Future<List<Product>> getProducts() async {
    try {
      var url = Uri.parse(ApiConstants.baseURL + ApiConstants.products);
      http.Response response = await http.get(
        url,
        headers: ApiConstants.headers,
      );
      var jsondata = jsonDecode(response.body);
      List<Product> tr = [];

      for (var data in jsondata['products']) {
        tr.add(Product.fromJson(data as Map<String, dynamic>));
      }

      return tr;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future addProduct(String libelle, int quantity, int price) async {
    try {
      Map<String, dynamic> data = {
        "libelle": libelle,
        "quantity": quantity,
        "price": price,
      };
      http.Response response = await CallApi().postData(data, ApiConstants.product);
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future updateProduct(int id, String libelle, int quantity, int price) async {
    try {
      Map<String, dynamic> data = {
        "libelle": libelle,
        "quantity": quantity,
        "price": price,
      };
      http.Response response = await CallApi().putData(data, ApiConstants.product + "/${id}");
    } catch (e) {
      print(e.toString());
    }
  }

  static deleteProduct(int id, VoidCallback refresh) async {
    try {
      dynamic response = CallApi().deleteData(ApiConstants.product + "/${id}");
      refresh();
    } catch (e) {
      print(e.toString());
    }
  }
}
