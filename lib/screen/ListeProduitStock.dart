import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/ConsulterVente.dart';

class ListeProduitStock extends StatefulWidget {
  const ListeProduitStock({Key? key}) : super(key: key);

  @override
  _ListeProduitStockState createState() => _ListeProduitStockState();
}

void main() => runApp(ListeProduitStock());

class _ListeProduitStockState extends State<ListeProduitStock> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste des produits',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListScreen(),
    );
  }
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product('Produit 1', 19.99),
    Product('Produit 2', 29.99),
    Product('Produit 3', 39.99),
    Product('Produit 4', 49.99),
    Product('Produit 5', 59.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des produits'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            onTap: () {
              // Action à effectuer lorsque l'utilisateur appuie sur un produit
              // Par exemple, ajouter le produit au panier ou afficher les détails du produit
              // Ici, nous affichons simplement une boîte de dialogue avec le nom du produit
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Produit sélectionné'),
                    content: Text('Vous avez sélectionné ${product.name}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
