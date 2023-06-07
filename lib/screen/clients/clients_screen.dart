import 'package:flutter/material.dart';
import 'package:flutter_application_1/dimensions/dimensions.dart';
import 'package:flutter_application_1/screen/clients/update_client.dart';
import 'package:flutter_application_1/services/client_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/add_client");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Gestion de clients"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: ClientServices.getClients(),
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
                              "Pas de client",
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
                                  ClientServices.deleteClient(snapshot.data![index].id, () {
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
                                  Get.to(UpdateClient(client: snapshot.data![index]));
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.account_circle_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Nom : ${snapshot.data![index].name}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Email : ${snapshot.data![index].email}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Tél : ${snapshot.data![index].tel}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Spacer(),
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
