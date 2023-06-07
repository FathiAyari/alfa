import 'package:flutter/material.dart';

class Parametre extends StatefulWidget {
  @override
  _ParametreState createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  TextEditingController _codeController = TextEditingController();
  TextEditingController _libelleController = TextEditingController();
  TextEditingController _tvaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  List<List<String>> _data = [];

  @override
  void dispose() {
    _codeController.dispose();
    _libelleController.dispose();
    _tvaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gérer Famille /TVA'),
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
                  Text('Code Famille'),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _codeController,
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
                  Text('Libelle Famille'),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _libelleController,
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
                  Text('Id TVA'),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _tvaController,
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
