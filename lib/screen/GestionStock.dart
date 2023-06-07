import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/Ajouter.dart';
import 'package:flutter_application_1/screen/Modifier.dart';
import 'package:flutter_application_1/screen/Supprimer.dart';

class GestionStock extends StatelessWidget {
  const GestionStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion de stock'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Action à effectuer lors du clic sur l'icône de notification
              // Par exemple, afficher une boîte de dialogue ou une page de notifications
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ajouter()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Ajouter'),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 25),
                minimumSize: const Size(180, 60),
                primary: Color.fromARGB(255, 127, 227, 131),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Modifier()),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier'),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 15),
                    minimumSize: const Size(150, 60),
                    primary: Color.fromARGB(255, 127, 227, 131),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Supprimer()),
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Supprimer'),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 15),
                    minimumSize: const Size(150, 60),
                    primary: Color.fromARGB(255, 127, 227, 131),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
