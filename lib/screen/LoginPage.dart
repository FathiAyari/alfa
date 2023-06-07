import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/Accueil.dart';
import 'package:flutter_application_1/screen/RegistrationPage.dart';
import 'package:flutter_application_1/services/auth_services.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  bool loading = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => avoidReturnButton(),
      child: Scaffold(
        backgroundColor: Colors.white,
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
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Connexion',
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
                    obscureText: !passwordVisible,
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
                          passwordVisible ? Icons.visibility_off : Icons.visibility,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: loading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    AuthServices.login(emailController.text, _passwordController.text).then((value) {
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
                          child: loading
                              ? SizedBox(height: 25, width: 25, child: CircularProgressIndicator())
                              : Text('Se connecter'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegistrationPage()),
                            );
                          },
                          child: Text('S\'inscrire'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
