import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/archive/view_pdf.dart';
import 'package:get/get.dart';

class DataPerDay extends StatefulWidget {
  final List data;
  const DataPerDay({Key? key, required this.data}) : super(key: key);

  @override
  State<DataPerDay> createState() => _DataPerDayState();
}

class _DataPerDayState extends State<DataPerDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.to(ViewPdf(
                      path: widget.data[index],
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
                            "${widget.data[index]}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
