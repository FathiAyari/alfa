import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/ListeProduitStock.dart';
import 'package:flutter_application_1/screen/GestionStock.dart';

class Ajouter extends StatefulWidget {
  const Ajouter({Key? key}) : super(key: key);

  @override
  _AjouterState createState() => _AjouterState();
}

class _AjouterState extends State<Ajouter> {
  // Les variables qui stockent les valeurs entrées par l'utilisateur
  late String _id;
  late String _prix;
  late String _nom;
  late String _quantite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un produit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Champ pour l'ID
            const Text('ID :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _id = value;
                });
              },
            ),

            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour le prix
            const Text('Prix :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _prix = value;
                });
              },
            ),

            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour le nom
            const Text('Nom :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _nom = value;
                });
              },
            ),

            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour la quantité
            const Text('Quantité :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _quantite = value;
                });
              },
            ),

            const SizedBox(height: 40), // Ajout d'une marge de 20 pixels

            // Bouton pour enregistrer les données
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 127, 227, 131),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeProduitStock()),
                );
                // Effectuez votre traitement ici en utilisant les valeurs stockées dans les variables
                print('ID : $_id');
                print('Prix : $_prix');
                print('Nom : $_nom');
                print('Quantité : $_quantite');
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
