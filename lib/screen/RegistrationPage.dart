import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/Accueil.dart';
import 'package:flutter_application_1/services/auth_services.dart';
import 'package:get_storage/get_storage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _passwordVisible = false;
  bool loading = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade300,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Inscription',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "champ obligatoire";
                    }
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Entrez votre Nom et prénom',
                    hintStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white.withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.blue),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "champ obligatoire";
                    } else {
                      bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

                      if (!emailValid) {
                        return " format invalide d'email";
                      }
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Entrez votre adresse e-mail',
                    hintStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white.withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.blue),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "champ obligatoire";
                    }
                  },
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Entrez votre mot de passe',
                    hintStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white.withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  style: TextStyle(color: Colors.blue),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: 140,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              AuthServices.register(nameController.text, emailController.text, _passwordController.text)
                                  .then((value) {
                                Map responseMap = jsonDecode(value.body);
                                setState(() {
                                  loading = false;
                                });
                                if (value.statusCode == 200) {
                                  GetStorage().write('user', {
                                    'email': responseMap['user']["email"],
                                    'name': responseMap['user']["name"],
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Accueil()),
                                  );
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text("${responseMap['error']}"),
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
                          },
                    child: loading ? SizedBox(height: 25, width: 25, child: CircularProgressIndicator()) : Text('S\'inscrire'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
