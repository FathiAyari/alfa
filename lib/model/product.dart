class Product {
  final int id;

  final String libelle;
  final double quantity;
  final double price;

  Product({
    required this.libelle,
    required this.quantity,
    required this.price,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      libelle: json['libelle'],
      quantity: json['quantity'].toDouble(),
      price: json['price'].toDouble(),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'libelle': libelle,
      'quantity': quantity,
      'price': price,
    };
  }
}
