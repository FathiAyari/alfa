import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/AjouterClient.dart';
import 'package:flutter_application_1/screen/AjouterLivraison.dart';
import 'package:flutter_application_1/screen/ModifierVente.dart';

class ModifierVente extends StatefulWidget {
  const ModifierVente({Key? key}) : super(key: key);

  @override
  _ModifierVenteState createState() => _ModifierVenteState();
}

class _ModifierVenteState extends State<ModifierVente> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _nomClientController = TextEditingController();
  TextEditingController _nomProduitController = TextEditingController();
  TextEditingController _quantiteController = TextEditingController();
  TextEditingController _livraisonController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  List<List<String>> _data = [];

  @override
  void dispose() {
    _idController.dispose();
    _nomClientController.dispose();
    _nomProduitController.dispose();
    _quantiteController.dispose();
    _livraisonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Vente'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Action à effectuer lors du clic sur l'icône de notification
              // Par exemple, afficher une boîte de dialogue ou une page de notifications
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  Text('ID'),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _idController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez remplir ce champ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Nom Produit'),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _nomProduitController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez remplir ce champ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Quantité'),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _quantiteController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez remplir ce champ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Client'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange.shade400,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AjouterClient()),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Livraison'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange.shade400,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AjouterLivraison()),
                      );
                    },
                  ),
                  SizedBox(height: 32.0),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          child: Text('valider Modification'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange.shade400,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _data.add([
                                _idController.text,
                                _nomClientController.text,
                                _nomProduitController.text,
                                _quantiteController.text,
                              ]);

                              setState(() {
                                _idController.text = '';
                                _nomClientController.text = '';
                                _nomProduitController.text = '';
                                _quantiteController.text = '';
                                _livraisonController.text = '';
                                _errorMessage = '';
                              });
                            } else {
                              setState(() {
                                _errorMessage =
                                    'Veuillez remplir tous les champs';
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Center(
                    child: Container(
                      width: 80.0,
                      height: 40,
                      child: TextFormField(
                        enabled: false,
                        initialValue: 'Prix',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: Text('ID')),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: Text('Client')),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: Text('Nom Produit')),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: Text('Quantité')),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: Text('Livrason')),
                            ),
                          ),
                        ],
                      ),
                      ..._data.map(
                        (row) => TableRow(
                          children: [
                            TableCell(
                              child: Center(child: Text(row[0])),
                            ),
                            TableCell(
                              child: Center(child: Text(row[1])),
                            ),
                            TableCell(
                              child: Center(child: Text(row[2])),
                            ),
                            TableCell(
                              child: Center(child: Text(row[3])),
                            ),
                            TableCell(
                              child: Center(child: Text(row[4])),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
