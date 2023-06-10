import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/composants/btn/action_button.dart';
import 'package:flutter_application_1/dimensions/dimensions.dart';
import 'package:flutter_application_1/model/client.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/screen/archive/all_archives.dart';
import 'package:flutter_application_1/services/client_services.dart';
import 'package:flutter_application_1/services/sale_services.dart';
import 'package:flutter_application_1/services/stock_services.dart';
import 'package:image_picker/image_picker.dart';

class AddArchive extends StatefulWidget {
  const AddArchive({Key? key}) : super(key: key);

  @override
  State<AddArchive> createState() => _AddArchiveState();
}

class _AddArchiveState extends State<AddArchive> {
  File? _image;
  Future getProfileImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Product? selectedProduct;
  Client? selectedClient;
  List<Product> products = [];
  List<Client> clients = [];
  bool loading = false;
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

  @override
  void initState() {
    super.initState();
    getProducts();
    getClients();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllArchives()));
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getProfileImage();
          },
          child: Icon(Icons.image),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllArchives()));
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Ajouter une facture"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              if (_image != null)
                InkWell(
                  onTap: () {
                    getProfileImage();
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )),
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
                        } else if (_image == null) {
                          final snackBar = SnackBar(
                            content: Text("il faut choisir une image"),
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
                          SaleServices.generatePdfFromImage(_image!.path, selectedClient!.name, selectedProduct!.libelle)
                              .then((value) {
                            setState(() {
                              loading = false;
                            });
                            final snackBar = SnackBar(
                              content: Text("Archive bien ajouté "),
                              backgroundColor: (Colors.red),
                              action: SnackBarAction(
                                label: 'Fermer',
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllArchives()));
                          });
                        }
                      })
            ],
          ),
        ),
      ),
    );
  }
}
