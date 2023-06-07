import 'package:flutter/material.dart';
import 'package:flutter_application_1/composants/btn/action_button.dart';
import 'package:flutter_application_1/composants/inputs/input_field.dart';
import 'package:flutter_application_1/model/client.dart';
import 'package:flutter_application_1/services/client_services.dart';

class UpdateClient extends StatefulWidget {
  final Client client;
  const UpdateClient({Key? key, required this.client}) : super(key: key);

  @override
  State<UpdateClient> createState() => _UpdateClientState();
}

class _UpdateClientState extends State<UpdateClient> {
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      nameController.text = widget.client.name;
      telController.text = widget.client.tel;
      emailController.text = widget.client.email;
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le client"),
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
                      label: "Mettre à jour",
                      buttonColor: Colors.blue,
                      labelColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          ClientServices.updateClient(
                                  widget.client.id, nameController.text, telController.text, emailController.text)
                              .then((value) {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, "/clients");
                            final snackBar = SnackBar(
                              content: Text("Client modifié"),
                              backgroundColor: (Colors.blue),
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
