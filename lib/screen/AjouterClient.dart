import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/ListeClients.dart';
import 'package:flutter_application_1/screen/ConsulterVente.dart';

class AjouterClient extends StatefulWidget {
  const AjouterClient({Key? key}) : super(key: key);

  @override
  _AjouterClientState createState() => _AjouterClientState();
}

class _AjouterClientState extends State<AjouterClient> {
  // Les variables qui stockent les valeurs entrées par l'utilisateur
  late String _matriculefascale;
  late String _prenom_Client;
  late String _fax;
  late String _email;
  late String _adresse;
  late String _telephone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Champ pour matricule
            const Text('Matricule Fascale :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _matriculefascale = value;
                });
              },
            ),

            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour le prenom
            const Text('Prénom de Client :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _prenom_Client = value;
                });
              },
            ),

            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour le fax
            const Text('Fax :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _fax = value;
                });
              },
            ),

            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour email
            const Text('Email :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour adresse
            const Text('Adresse :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _adresse = value;
                });
              },
            ),
            const SizedBox(height: 20), // Ajout d'une marge de 20 pixels

            // Champ pour le nom
            const Text('Téléphone :'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _telephone = value;
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
                // Effectuez votre traitement ici en utilisant les valeurs stockées dans les variables
                print('Matricule Client : $_matriculefascale');
                print('Prénom de Client : $_prenom_Client');
                print('Fax Client: $_fax');
                print('Email Client: $_email');
                print('Adresse Client: $_adresse');
                print('Téléphone Client: $_telephone');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeClients()),
                );
              },
              child: const Text('Enregistrer'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 127, 227, 131),
              ),
              onPressed: () {
                // Effectuez votre traitement ici en utilisant les valeurs stockées dans les variables
                print('Matricule Fascale : $_matriculefascale');
                print('Prénom de Client : $_prenom_Client');
                print('Fax : $_fax');
                print('Email : $_email');
                print('Adresse : $_adresse');
                print('Téléphone : $_telephone');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeClients()),
                );
              },
              child: const Text('Liste Clients'),
            ),
          ],
        ),
      ),
    );
  }
}
