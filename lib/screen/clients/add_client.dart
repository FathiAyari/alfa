import 'package:flutter/material.dart';
import 'package:flutter_application_1/composants/btn/action_button.dart';
import 'package:flutter_application_1/composants/inputs/input_field.dart';
import 'package:flutter_application_1/services/client_services.dart';

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un client"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputField(
                label: "Nom de client",
                controller: nameController,
                textInputType: TextInputType.text,
              ),
              InputField(
                label: "adresse de client",
                controller: adressController,
                textInputType: TextInputType.text,
              ),
              InputField(
                label: "Email de client",
                controller: emailController,
                textInputType: TextInputType.emailAddress,
              ),
              InputField(
                label: "Tél de client",
                controller: telController,
                textInputType: TextInputType.emailAddress,
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
                          setState(() {
                            loading = true;
                          });
                          ClientServices.addClient(
                                  nameController.text, telController.text, emailController.text, adressController.text)
                              .then((value) {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, "/clients");

                            final snackBar = SnackBar(
                              content: Text("Client ajouté"),
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
