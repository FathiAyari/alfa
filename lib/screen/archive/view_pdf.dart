import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_const.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ViewPdf extends StatefulWidget {
  final String path;
  const ViewPdf({Key? key, required this.path}) : super(key: key);

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  @override
  Widget build(BuildContext context) {
    print(widget.path);
    return Scaffold(
      appBar: AppBar(),
      body: PDF().fromUrl(
        "http://${ApiConstants.ip}/storage/images/pdf/${widget.path}",
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
