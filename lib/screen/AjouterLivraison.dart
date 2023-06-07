import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/ConsulterVente.dart';

class AjouterLivraison extends StatefulWidget {
  const AjouterLivraison({Key? key}) : super(key: key);

  @override
  _AjouterLivraisonState createState() => _AjouterLivraisonState();
}

class _AjouterLivraisonState extends State<AjouterLivraison> {
  // Les variables qui stockent les valeurs entrées par l'utilisateur
  late String _remise;
  late String _totalht;
  late String _tva;
  late String _transport;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Ajouter Livraison'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Champ pour Remise
            const Text('Remise :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _remise = value;
                });
              },
            ),

            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour le Total
            const Text('Total HT :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _totalht = value;
                });
              },
            ),

            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour le TVA
            const Text('TVA :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _tva = value;
                });
              },
            ),

            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour la Transport
            const Text('Transport :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _transport = value;
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
                  MaterialPageRoute(builder: (context) => ConsulterVente()),
                );
                // Effectuez votre traitement ici en utilisant les valeurs stockées dans les variables
                print('Remise : $_remise');
                print('Total HT : $_totalht');
                print('TVA : $_tva');
                print('Transport : $_transport');
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
