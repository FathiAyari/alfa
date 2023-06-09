import 'package:flutter/material.dart';
import 'package:flutter_application_1/composants/btn/action_button.dart';
import 'package:flutter_application_1/composants/inputs/input_field.dart';
import 'package:flutter_application_1/dimensions/dimensions.dart';
import 'package:flutter_application_1/model/client.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/screen/sales/all_sales.dart';
import 'package:flutter_application_1/services/client_services.dart';
import 'package:flutter_application_1/services/sale_services.dart';
import 'package:flutter_application_1/services/stock_services.dart';

class AddSale extends StatefulWidget {
  const AddSale({Key? key}) : super(key: key);

  @override
  State<AddSale> createState() => _AddSaleState();
}

class _AddSaleState extends State<AddSale> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClients();
    getProducts();
  }

  Product? selectedProduct;
  Client? selectedClient;
  List<Product> products = [];
  List<Client> clients = [];
  getProducts() async {
    List<Product> productsList = await StockServices.getProducts();
    setState(() {
      products = productsList;
    });
  }

  getClients() async {
    List<Client> clientsList = await ClientServices.getClients();
    setState(() {
      clients = clientsList;
    });
  }

  TextEditingController deliveryController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un vente"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputField(
                  label: "Quantité",
                  controller: quantityController,
                  textInputType: TextInputType.number,
                ),
                InputField(
                  label: "Frais de livraison",
                  controller: deliveryController,
                  textInputType: TextInputType.number,
                ),
                InputField(
                  label: "Remise",
                  controller: discountController,
                  textInputType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: Constants.screenHeight * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: DropdownButton<Product>(
                      isExpanded: true,
                      value: selectedProduct,
                      hint: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Selectionner Produit"),
                      ),
                      underline: SizedBox(
                        height: 0,
                      ),
                      items: products.map<DropdownMenuItem<Product>>((Product product) {
                        return DropdownMenuItem<Product>(
                          key: Key(product.id.toString()),
                          value: product,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.libelle),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProduct = value!;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: Constants.screenHeight * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: DropdownButton<Client>(
                      isExpanded: true,
                      value: selectedClient,
                      hint: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Selectionner client"),
                      ),
                      underline: SizedBox(
                        height: 0,
                      ),
                      items: clients.map<DropdownMenuItem<Client>>((Client category) {
                        return DropdownMenuItem<Client>(
                          key: Key(category.id.toString()),
                          value: category,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(category.name),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClient = value!;
                        });
                      },
                    ),
                  ),
                ),
                loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ActionButton(
                        label: "Ajouter",
                        buttonColor: Colors.blue,
                        labelColor: Colors.white,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (selectedClient == null) {
                              final snackBar = SnackBar(
                                content: Text("Il faut choisir un client"),
                                backgroundColor: (Colors.red),
                                action: SnackBarAction(
                                  label: 'Fermer',
                                  textColor: Colors.white,
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            } else if (selectedProduct == null) {
                              final snackBar = SnackBar(
                                content: Text("il faut choisir un produit"),
                                backgroundColor: (Colors.red),
                                action: SnackBarAction(
                                  label: 'Fermer',
                                  textColor: Colors.white,
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            } else {
                              setState(() {
                                loading = true;
                              });
                              SaleServices.addSale(selectedProduct!.id, selectedClient!.id, double.parse(quantityController.text),
                                      double.parse(deliveryController.text), double.parse(discountController.text))
                                  .then((value) {
                                setState(() {
                                  loading = false;
                                });
                                if (value.statusCode == 200) {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllSalesScreen()));
                                  final snackBar = SnackBar(
                                    content: Text("Vente est bien ajouté"),
                                    backgroundColor: (Colors.green),
                                    action: SnackBarAction(
                                      label: 'Fermer',
                                      textColor: Colors.white,
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text("quantité insuffisante"),
                                    backgroundColor: (Colors.red),
                                    action: SnackBarAction(
                                      label: 'Fermer',
                                      textColor: Colors.white,
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              });
                            }
                          }
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
