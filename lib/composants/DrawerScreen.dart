import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/LoginPage.dart';
import 'package:flutter_application_1/screen/GestionArchive.dart';
import 'package:flutter_application_1/screen/GestionStock.dart';
import 'package:flutter_application_1/screen/ConsulterVente.dart';
import 'package:flutter_application_1/screen/Parametre.dart';
import 'package:flutter_application_1/screen/Accueil.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.blue.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/logo.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: .06, color: Color.fromARGB(255, 30, 29, 29)),
          ListTile(
            iconColor: Colors.blue.shade300,
            leading: const Icon(Icons.home),
            title: const Text('Accueil',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Accueil()),
              );
            },
          ),
          ListTile(
            iconColor: Colors.blue.shade300,
            leading: const Icon(Icons.sell),
            title: const Text('Gestion Vente',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConsulterVente()),
              );
            },
          ),
          ListTile(
            iconColor: Colors.blue.shade300,
            leading: const Icon(Icons.archive),
            title: const Text('Gestion Archive',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GestionArchive()),
              );
            },
          ),
          ListTile(
            iconColor: Colors.blue.shade300,
            leading: const Icon(Icons.manage_accounts),
            title: const Text('Gestion Stock',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GestionStock()),
              );
            },
          ),
          ListTile(
            iconColor: Colors.blue.shade300,
            leading: const Icon(Icons.settings),
            title: const Text('Paramètre',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Parametre()),
              );
              // Add Navigation logic here
            },
          ),
          ListTile(
            iconColor: Colors.blue.shade300,
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
