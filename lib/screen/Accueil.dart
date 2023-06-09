import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/composants/DrawerScreen.dart';
import 'package:flutter_application_1/screen/archive/all_archives.dart';
import 'package:flutter_application_1/screen/sales/all_sales.dart';
import 'package:flutter_application_1/services/auth_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'stock/products_screen.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(" Non"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => avoidReturnButton(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Page d\'accueil'),
        ),
        drawer: DrawerScreen(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildStatisticsRow(
                context,
              ),
              SizedBox(height: 16.0),
              _buildDashboardItemsColumn(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsRow(BuildContext context) {
    return FutureBuilder(
        future: AuthServices.home(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map responseMap = jsonDecode(snapshot.data!.body);

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildStatisticCard(
                              context, 'Clients', '${responseMap['clients']} clients', Colors.blue, Icons.person)),
                      SizedBox(width: 16.0),
                      Expanded(
                          child:
                              _buildStatisticCard(context, 'Produits ', '${responseMap['products']} ', Colors.green, Icons.book)),
                    ],
                  ),
                  SizedBox(width: 16.0),
                  Row(
                    children: [
                      Expanded(
                          child: _buildStatisticCard(context, 'Revenue de ${DateFormat("yyyy/MM/dd").format(DateTime.now())}',
                              '${responseMap['sum']}dt ', Colors.red, Icons.attach_money)),
                      // Add more statistics cards here
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildStatisticCard(BuildContext context, String title, String value, Color color, IconData icon) {
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
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllSalesScreen()),
                    );
                  },
                  child: _buildDashboardItem(
                    context,
                    'Gestion Vente',
                    Colors.orange.shade400,
                    Icons.shopping_cart,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllArchives()),
                    );
                  },
                  child: _buildDashboardItem(
                    context,
                    'Gestion Archive',
                    Colors.green,
                    Icons.archive,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductsScreen()),
                    );
                  },
                  child: _buildDashboardItem(
                    context,
                    'Gestion Stock',
                    Color.fromARGB(255, 127, 227, 131),
                    Icons.abc_sharp,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed("/clients");
                  },
                  child: _buildDashboardItem(
                    context,
                    'Gestion de clients',
                    Color.fromARGB(255, 127, 227, 131),
                    Icons.supervised_user_circle,
                  ),
                ),
              ),
            ),
          ],
        )
        // Add more dashboard items here
      ],
    );
  }

  Widget _buildDashboardItem(BuildContext context, String title, Color color, IconData icon) {
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
