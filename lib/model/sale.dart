import 'package:flutter_application_1/model/client.dart';
import 'package:flutter_application_1/model/product.dart';

class Sale {
  final int id;
  final Product product;
  final Client client;
  final double quantity;
  final double delivery;
  final double discount;
  final double? price;
  final DateTime created_at;

  Sale({
    required this.product,
    required this.client,
    required this.quantity,
    required this.delivery,
    required this.discount,
    required this.created_at,
    this.price,
    required this.id,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
        product: Product.fromJson(json['product']),
        client: Client.fromJson(json['client']),
        quantity: json['quantity'].toDouble(),
        delivery: json['delivery'].toDouble(),
        discount: json['discount'].toDouble(),
        created_at: DateTime.parse(json['created_at']),
        price: json['price'].toDouble(),
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'client': client.toJson(),
      'quantity': quantity,
      'delivery': delivery,
      'discount': discount,
    };
  }
}
