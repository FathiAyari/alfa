import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/ConsulterVente.dart';
import 'package:flutter_application_1/screen/AjouterClient.dart';

class ListeClients extends StatefulWidget {
  const ListeClients({Key? key}) : super(key: key);

  @override
  _ListeClientsState createState() => _ListeClientsState();
}

void main() => runApp(ListeClients());

class _ListeClientsState extends State<ListeClients> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste des clients',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClientListScreen(),
    );
  }
}

class ClientListScreen extends StatelessWidget {
  final List<String> clients = [
    'Client 1',
    'Client 2',
    'Client 3',
    'Client 4',
    'Client 5',
    'Client 6',
    'Client 7',
    'Client 8',
    'Client 9',
    'Client 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des clients'),
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (BuildContext context, int index) {
          final clientName = clients[index];
          return ListTile(
            title: Text(clientName),
            onTap: () {
              // Action à effectuer lorsque l'utilisateur appuie sur un client
              // Par exemple, naviguer vers une autre page pour afficher les détails du client
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientDetailsScreen(clientName),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ClientDetailsScreen extends StatelessWidget {
  final String clientName;

  ClientDetailsScreen(this.clientName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du client'),
      ),
      body: Center(
        child: Text('Détails du client : $clientName'),
      ),
    );
  }
}
