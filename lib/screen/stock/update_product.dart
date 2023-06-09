import 'package:flutter/material.dart';
import 'package:flutter_application_1/composants/btn/action_button.dart';
import 'package:flutter_application_1/composants/inputs/input_field.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/screen/stock/products_screen.dart';
import 'package:flutter_application_1/services/stock_services.dart';

class UpdateProduct extends StatefulWidget {
  final Product product;
  const UpdateProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    labelController.text = widget.product.libelle;
    priceController.text = widget.product.price.toString();
    quantityController.text = widget.product.quantity.toString();
  }

  TextEditingController labelController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier produit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputField(
                label: "Libellé de produit",
                controller: labelController,
                textInputType: TextInputType.text,
              ),
              InputField(
                label: "Quantité de produit",
                controller: quantityController,
                textInputType: TextInputType.number,
              ),
              InputField(
                label: "Pix de KG ",
                controller: priceController,
                textInputType: TextInputType.number,
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ActionButton(
                      label: "Mettre à jour",
                      buttonColor: Colors.blue,
                      labelColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          StockServices.updateProduct(widget.product.id, labelController.text,
                                  double.parse(quantityController.text), double.parse(priceController.text))
                              .then((value) {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductsScreen()));

                            final snackBar = SnackBar(
                              content: Text("Produit modifié"),
                              backgroundColor: (Colors.green),
                              action: SnackBarAction(
                                label: 'Fermer',
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
