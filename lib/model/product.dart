class Product {
  final int id;

  final String libelle;
  final int quantity;
  final int price;

  Product({
    required this.libelle,
    required this.quantity,
    required this.price,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      libelle: json['libelle'],
      quantity: json['quantity'],
      price: json['price'],
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
