import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/Accueil.dart';
import 'package:flutter_application_1/screen/Parametre.dart';
import 'package:flutter_application_1/screen/archive/all_archives.dart';
import 'package:flutter_application_1/screen/clients/clients_screen.dart';
import 'package:flutter_application_1/screen/sales/all_sales.dart';
import 'package:flutter_application_1/screen/stock/products_screen.dart';
import 'package:flutter_application_1/services/auth_services.dart';

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
                MaterialPageRoute(builder: (context) => AllSalesScreen()),
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
                MaterialPageRoute(builder: (context) => AllArchives()),
              );
            },
          ),
          ListTile(
            iconColor: Colors.blue.shade300,
            leading: const Icon(Icons.manage_accounts),
            title: const Text('Gestion de Stock',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductsScreen()),
              );
            },
          ),
          ListTile(
            iconColor: Colors.blue.shade300,
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('Gestion de clients',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClientsScreen()),
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
              AuthServices.logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
