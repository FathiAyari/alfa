import 'package:flutter/material.dart';
import 'package:flutter_application_1/dimensions/dimensions.dart';
import 'package:flutter_application_1/screen/stock/add_product.dart';
import 'package:flutter_application_1/screen/stock/update_product.dart';
import 'package:flutter_application_1/services/stock_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddProduct());
        },
      ),
      appBar: AppBar(
        title: Text("Gestion de stock"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: StockServices.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Container(
                        height: Constants.screenHeight * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Pas de produits",
                              style: TextStyle(fontSize: 20, fontFamily: "NunitoBold", color: Colors.black.withOpacity(0.5)),
                            )
                          ],
                        ),
                      ));
                    });
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Slidable(
                          key: const ValueKey(0),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (cte) {},
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                icon: Icons.cancel,
                                label: 'annuler',
                              ),
                              SlidableAction(
                                onPressed: (ctx) async {
                                  StockServices.deleteProduct(snapshot.data![index].id, () {
                                    setState(() {});
                                  });
                                },
                                backgroundColor: Colors.red.withOpacity(0.7),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: "Supprimer",
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (ctx) async {
                                  Get.to(UpdateProduct(product: snapshot.data![index]));
                                },
                                backgroundColor: Colors.blue.withOpacity(0.7),
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: "Modifier",
                              ),
                              SlidableAction(
                                onPressed: null,
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                icon: Icons.cancel,
                                label: 'annuler',
                              ),
                            ],
                          ),
                          child: Container(
                            height: Constants.screenHeight * 0.1,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Libellé : ${snapshot.data![index].libelle}",
                                          style: TextStyle(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Quantité : ${snapshot.data![index].quantity}",
                                          style: TextStyle(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Prix de KG : ${snapshot.data![index].price}",
                                          style: TextStyle(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Image.asset('assets/logo.png', height: Constants.screenHeight * 0.05),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
