import 'package:flutter/material.dart';

class ModifierStock extends StatefulWidget {
  @override
  _ModifierStockState createState() => _ModifierStockState();
}

class _ModifierStockState extends State<ModifierStock> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _prixController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _quantiteController = TextEditingController();

  bool _hasChanges = false;
  bool _showSuccessMessage = false;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with some default values
    _idController.text = '1';
    _prixController.text = '750';
    _nomController.text = 'alfa 1ére type';
    _quantiteController.text = '1500';
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    hintText: 'Entrez Id',
                  ),
                ),
                TextFormField(
                  controller: _prixController,
                  decoration: InputDecoration(
                    labelText: 'Prix ',
                    hintText: 'Entrez prix ',
                  ),
                ),
                TextFormField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    hintText: 'Entrez nom de produit',
                  ),
                ),
                TextFormField(
                  controller: _quantiteController,
                  decoration: InputDecoration(
                    labelText: 'Quantité',
                    hintText: 'Entrez quantité',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasChanges = true;
                });
                Navigator.of(context).pop();
              },
              child: Text('Sauvegarder '),
            ),
          ],
        );
      },
    );
  }

  void _showImagePickerDialog() {
    // Add image picker dialog here
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mise à jour du Stock réussie'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' modifier Stock',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: _showImagePickerDialog,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage:
                    NetworkImage('logo.jpg'), // Replace with your image URL
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '${_nomController.text}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'ID: ${_idController.text}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Quantité: ${_quantiteController.text}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _showEditDialog,
                  child: Text('Editer le produit'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_hasChanges) {
                      // Add functionality to save changes to profile
                      setState(() {
                        _hasChanges = false;
                        _showSuccessMessage = true;
                      });
                      _showSuccessSnackbar();
                    } else {
                      // Add functionality to do something else (e.g. go back)
                    }
                  },
                  child: Text('Sauvegarder les modifications'),
                ),
              ],
            ),
            _showSuccessMessage
                ? Text(
                    'Produit modfier avec suceés !',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
);    
  }
}
