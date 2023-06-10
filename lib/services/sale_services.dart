import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/dimensions/dimensions.dart';
import 'package:flutter_application_1/model/sale.dart';
import 'package:flutter_application_1/services/api_const.dart';
import 'package:flutter_application_1/services/callapi.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class SaleServices {
  static deleteSale(int id, VoidCallback test) async {
    http.Response response = await CallApi().deleteData(ApiConstants.sale + "/$id");
    test();
  }

  static Future<List<Sale>> getSales() async {
    try {
      var url = Uri.parse(ApiConstants.baseURL + ApiConstants.sales);
      http.Response response = await http.get(
        url,
        headers: ApiConstants.headers,
      );
      var jsondata = jsonDecode(response.body);
      List<Sale> tr = [];

      for (var data in jsondata['sales']) {
        tr.add(Sale.fromJson(data as Map<String, dynamic>));
      }

      return tr;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<http.Response> addSale(int product_id, int client_id, double quantity, double delivery, double discount) async {
    Map<String, dynamic> data = {
      "product_id": product_id,
      "client_id": client_id,
      "quantity": quantity,
      "delivery": delivery,
      "discount": discount,
    };
    print(data);
    http.Response response = await CallApi().postData(data, ApiConstants.sale);
    print(response.body);
    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      await createPDF(Sale.fromJson(jsondata['sale']));
    }
    return response;
  }

  static Future<void> createPDF(Sale sale) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString(
        "Facture de vente ",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          20,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.4, 25, 300, 50));

    page.graphics.drawString(
        "Nom de societé  : Alfa ",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 75, 300, 50));
    page.graphics.drawString(
        "Lieu de societé :Sfax",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 125, 300, 50));
    page.graphics.drawString(
        "Nom de client :${sale.client.name}",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 175, 300, 50));
    page.graphics.drawString(
        "Tél de client :${sale.client.tel}",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 225, 300, 50));
    page.graphics.drawString(
        "Email de client :${sale.client.email}",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 275, 300, 50));
    page.graphics.drawString(
        "Produit :${sale.product.libelle}",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 325, 300, 50));
    page.graphics.drawString(
        "Quantité de produit :${sale.quantity}",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 375, 300, 50));
    page.graphics.drawString(
        "frais de livraison  :${sale.delivery}",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 425, 300, 50));
    page.graphics.drawString(
        "Remise :${sale.discount}",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 475, 300, 50));
    page.graphics.drawString(
        "TTC :${sale.price}",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          17,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.001, 525, 300, 50));

    document.save().then((value) {
      List<int> bytes = value;

      saveAndLaunchFile(bytes,
          '${sale.client.name}_${sale.product.libelle}_${DateFormat('yyyy_MM_dd_hh_mm').format(DateTime.now())}.pdf', sale.id);
    });
  }

  static Future<void> saveAndLaunchFile(List<int> bytes, String fileName, [int? sale]) async {
    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.baseURL + ApiConstants.pdf + (sale != null ? "/${sale}" : "")))
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath('image', "$path/$fileName"));
    var response = await request.send();
  }

  /// deal with images

  static Future generatePdfFromImage(String file, clientName, productName) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    final bytes = File(file).readAsBytesSync();
    final image = PdfBitmap(bytes);
    // Get the image dimensions
    final imageWidth = image.width.toDouble();
    final imageHeight = image.height.toDouble();

    // Calculate the scale factors for the image
    final pageWidth = page.getClientSize().width.toDouble();
    final pageHeight = page.getClientSize().height.toDouble();
    final scaleX = pageWidth / imageWidth;
    final scaleY = pageHeight / imageHeight;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    // Calculate the position to center the image on the page
    final offsetX = (pageWidth - imageWidth * scale) / 2;
    final offsetY = (pageHeight - imageHeight * scale) / 2;

    page.graphics.drawString(
        "Facture de vente ",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          20,
        ),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(Constants.screenWidth * 0.4, 25, 300, 50));
    page.graphics.drawImage(
      image,
      Rect.fromLTWH(0, 100, pageWidth, pageHeight),
    );
    document.save().then((value) {
      List<int> bytes = value;

      saveAndLaunchFile(bytes, "${clientName}_${productName}_${DateFormat('yyyy_MM_dd_hh_mm').format(DateTime.now())}.pdf");
    });
  }
}
