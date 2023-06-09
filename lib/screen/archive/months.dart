import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/archive/data_per_day.dart';
import 'package:get/get.dart';

class Months extends StatefulWidget {
  final Map<String, dynamic> data;
  const Months({Key? key, required this.data}) : super(key: key);

  @override
  State<Months> createState() => _MonthsState();
}

class _MonthsState extends State<Months> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              final months = widget.data.keys.toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.to(DataPerDay(data: widget.data[months[index]]));
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
                            "${months[index]}",
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
