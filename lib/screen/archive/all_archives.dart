import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/composants/inputs/input_field.dart';
import 'package:flutter_application_1/dimensions/dimensions.dart';
import 'package:flutter_application_1/screen/archive/add_archive.dart';
import 'package:flutter_application_1/screen/archive/months.dart';
import 'package:flutter_application_1/screen/archive/view_pdf.dart';
import 'package:flutter_application_1/services/api_const.dart';
import 'package:flutter_application_1/services/archives_services.dart';
import 'package:flutter_application_1/services/callapi.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllArchives extends StatefulWidget {
  const AllArchives({Key? key}) : super(key: key);

  @override
  State<AllArchives> createState() => _AllArchivesState();
}

class _AllArchivesState extends State<AllArchives> {
  List<String> filteredData = [];
  filterData(String value) async {
    http.Response response = await CallApi().getData(ApiConstants.allpdf);
    List<String> filtered = [];
    var data = jsonDecode(response.body);
    for (var product in data) {
      if (product.toLowerCase().contains(value.toLowerCase())) {
        setState(() {
          filtered.add(product);
        });
      }
    }
    setState(() {
      filteredData = filtered;
    });
  }

  TextEditingController controller = TextEditingController();
  Widget getbodyWidget() {
    if (filteredData.isEmpty && controller.text.isEmpty) {
      return Expanded(
        child: FutureBuilder(
          future: ArchivesServices.getSales(),
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
                              "Pas des elements dans l'archive",
                              style: TextStyle(fontSize: 20, fontFamily: "NunitoBold", color: Colors.black.withOpacity(0.5)),
                            )
                          ],
                        ),
                      ));
                    });
              } else {
                final yearKeys = snapshot.data!.keys.toList();
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(Months(
                              data: snapshot.data![yearKeys[index]],
                            ));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.folder,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "${yearKeys[index]}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
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
      );
    } else {
      if (filteredData.isNotEmpty) {
        return Expanded(
          child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(ViewPdf(
                        path: filteredData[index],
                      ));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.picture_as_pdf,
                              color: Colors.white,
                            ),
                            Text(
                              "${filteredData[index]}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      } else {
        return Expanded(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Center(
                    child: Container(
                  height: Constants.screenHeight * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pas des elements dans l'archive",
                        style: TextStyle(fontSize: 20, fontFamily: "NunitoBold", color: Colors.black.withOpacity(0.5)),
                      )
                    ],
                  ),
                ));
              }),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddArchive());
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Gestion de Archives"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                InputField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        filteredData = [];
                      });
                    } else {
                      filterData(value);
                    }
                  },
                  prefixWidget: Icon(Icons.search),
                  label: 'Nom de client , produit',
                  textInputType: TextInputType.text,
                  controller: controller,
                ),
                getbodyWidget()
              ],
            ),
          ),
        ));
  }
}
