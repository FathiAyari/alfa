import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/GestionArchive.dart';
import 'package:flutter_application_1/screen/GestionStock.dart';
import 'package:flutter_application_1/screen/ConsulterVente.dart';
import 'package:flutter_application_1/composants/DrawerScreen.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'accueil'),
      ),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStatisticsRow(context),
            SizedBox(height: 16.0),
            _buildDashboardItemsColumn(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              _buildStatisticCard(
                  context, 'Statistique 1', '123', Colors.blue, Icons.person),
              SizedBox(width: 16.0),
              _buildStatisticCard(context, 'Statistique 2', '456', Colors.red,
                  Icons.attach_money),
            ],
          ),
          SizedBox(width: 16.0),
          Column(
            children: [
              _buildStatisticCard(
                  context, 'Statistique 3', '789', Colors.green, Icons.book),
              SizedBox(width: 16.0),
              _buildStatisticCard(context, 'Statistique 2', '456', Colors.red,
                  Icons.attach_money),
              // Add more statistics cards here
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard(BuildContext context, String title, String value,
      Color color, IconData icon) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItemsColumn(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConsulterVente()),
            );
          },
          child: _buildDashboardItem(
            context,
            'Gestion Vente',
            Colors.orange.shade400,
            Icons.shopping_cart,
          ),
        ),
        SizedBox(height: 16.0),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GestionArchive()),
            );
          },
          child: _buildDashboardItem(
            context,
            'Gestion Archive',
            Colors.green,
            Icons.archive,
          ),
        ),
        SizedBox(height: 16.0),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GestionStock()),
            );
          },
          child: _buildDashboardItem(
            context,
            'Gestion Stock',
            Color.fromARGB(255, 127, 227, 131),
            Icons.abc_sharp,
          ),
        ),
        // Add more dashboard items here
      ],
    );
  }

  Widget _buildDashboardItem(
      BuildContext context, String title, Color color, IconData icon) {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Accueil(),
  ));
}
