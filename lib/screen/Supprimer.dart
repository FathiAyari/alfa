import 'package:flutter/material.dart';

class Supprimer extends StatefulWidget {
  const Supprimer({Key? key}) : super(key: key);

  @override
  _SupprimerState createState() => _SupprimerState();
}

class _SupprimerState extends State<Supprimer> {
  // Liste des produits à afficher dans le tableau
  final List<Map<String, dynamic>> _produits = [
    {'id': '1', 'nom': 'Produit 1', 'prix': '10.00', 'quantite': '5'},
    {'id': '2', 'nom': 'Produit 2', 'prix': '20.00', 'quantite': '10'},
    {'id': '3', 'nom': 'Produit 3', 'prix': '30.00', 'quantite': '15'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supprimer les produits'),
      ),
      body: SingleChildScrollView(
         padding: EdgeInsets.only(top: 40.0,left: 10),
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nom')),
            DataColumn(label: Text('Prix')),
            DataColumn(label: Text('Quantité')),
            DataColumn(label: Text('Actions')),
          ],
          rows: _produits
              .map((produit) => DataRow(cells: [
                    DataCell(Text(produit['id'])),
                    DataCell(Text(produit['nom'])),
                    DataCell(Text(produit['prix'])),
                    DataCell(Text(produit['quantite'])),
                    DataCell(
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline, color: Colors.green),
                      ),
                    ),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
