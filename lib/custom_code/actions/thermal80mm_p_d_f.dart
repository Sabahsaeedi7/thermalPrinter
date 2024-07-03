// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:pdf_image_renderer/pdf_image_renderer.dart';

Future<FFUploadedFile> thermal80mmPDF(
  String? logoUrl,
  String companyNameEn,
  String address,
  String mobile,
  String landline,
  String? invDate,
  String? customerName,
  String? customerPhone,
  String? salesStaff,
  String? remarks,
  String? barCode,
  List<String>? itemsNameList,
  List<int>? itemsQtyList,
  List<double>? itemsDiscountList,
  List<double>? itemsTotalList,
  double? invoiceTotal,
  double? invoiceTotalDiscount,
  double? invoiceTotalNet,
  int? invoiceTotalQty,
  String? invoiceConditionsEn,
  bool? invoiceIsDuplicate,
  int? invoiceNumber,
  List<double>? itemsPriceList,
  double? paidAmount,
  double? unPaidAmount,
) async {
  // Add your function code here!
// Add your function code here!

  final pdf = pw.Document();
  // Fetching the image from the provided URL
  final response = await http.get(Uri.parse(logoUrl!));
  if (response.statusCode != 200) {
    throw Exception('Failed to load image: ${response.statusCode}');
  }
  final Uint8List logoBytes = response.bodyBytes;
  final arabicFont = await rootBundle.load('assets/fonts/Amiri-Bold.ttf');
  final arabicFontTtf = pw.Font.ttf(arabicFont);

  /////// REST OF YOUR FUNCTION CODE ///////

  /////// TABLE DATA ///////
  // Ensure that none of the lists are null
  if (itemsNameList == null ||
      itemsQtyList == null ||
      itemsPriceList == null ||
      itemsDiscountList == null ||
      itemsTotalList == null) {
    // Return empty PDF if any of the lists are null
    return const FFUploadedFile();
  }
  final tableData = <List<dynamic>>[];
  for (int i = 0; i < itemsNameList.length; i++) {
    tableData.add([
      itemsNameList[i],
      itemsQtyList[i],
      itemsPriceList[i],
      itemsDiscountList[i],
      itemsTotalList[i],
    ]);
  }

  // Create the table widget
  final table = pw.Table(
    children: [
      pw.TableRow(
        children: [
          pw.Text('Item'),
          pw.Text('Qty'),
          pw.Text('Price'),
          pw.Text('DSCT'),
          pw.Text('Total'),
        ],
      ),
      ...tableData.map((row) {
        return pw.TableRow(
          children: row.map((cell) => pw.Text(cell.toString())).toList(),
        );
      }).toList(),
    ],
    border: pw.TableBorder.all(width: 0.5),
    columnWidths: {
      0: const pw.FlexColumnWidth(2),
      1: const pw.FlexColumnWidth(1),
      2: const pw.FlexColumnWidth(1),
      3: const pw.FlexColumnWidth(1),
      4: const pw.FlexColumnWidth(1),
    },
  );

  // Build the PDF document
  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(fontSize: 8)),
      pageFormat: PdfPageFormat.roll80
          .applyMargin(left: 0, top: 0, right: 0, bottom: 0),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Container(
              alignment: pw.Alignment.center,
              child: pw.ClipRRect(
                child: pw.Image(
                  pw.MemoryImage(logoBytes),
                  width: 150.0,
                  height: 100.0,
                  alignment: pw.Alignment.center,
                  fit: pw.BoxFit.contain,
                ),
              ),
            ),
            pw.Divider(
              height: 5.0,
              thickness: 0.5,
              color: PdfColors.black,
            ),
            pw.Text(companyNameEn,
                style: pw.TextStyle(fontSize: 8.0, font: arabicFontTtf),
                textAlign: pw.TextAlign.center,
                textDirection: pw.TextDirection.rtl),
            pw.Text(
              address,
              textAlign: pw.TextAlign.center,
              style: const pw.TextStyle(fontSize: 8.0),
            ),
            pw.Text(
              '$mobile | $landline',
              textAlign: pw.TextAlign.center,
              style: const pw.TextStyle(fontSize: 8.0),
            ),
            pw.Divider(
              height: 5.0,
              thickness: 0.5,
              color: PdfColors.black,
            ),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'INVOICE #$invoiceNumber',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 11.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            if (invoiceIsDuplicate!)
              pw.Container(
                width: double.infinity,
                child: pw.Text(
                  '----- DUPLICATE -----',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 11.0,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.Row(
              mainAxisSize: pw.MainAxisSize.max,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('DATE', style: const pw.TextStyle(fontSize: 8.0)),
                pw.Text(invDate!, style: const pw.TextStyle(fontSize: 8.0))
              ],
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.Row(
              mainAxisSize: pw.MainAxisSize.max,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('CUSTOMER', style: const pw.TextStyle(fontSize: 8.0)),
                pw.Text(customerName!, style: const pw.TextStyle(fontSize: 8.0))
              ],
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.Row(
              mainAxisSize: pw.MainAxisSize.max,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('MOBILE', style: const pw.TextStyle(fontSize: 8.0)),
                pw.Text(customerPhone!,
                    style: const pw.TextStyle(fontSize: 8.0))
              ],
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.Row(
              mainAxisSize: pw.MainAxisSize.max,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('SALES STAFF',
                    style: const pw.TextStyle(fontSize: 8.0)),
                pw.Text(salesStaff!, style: const pw.TextStyle(fontSize: 8.0))
              ],
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.Row(
              mainAxisSize: pw.MainAxisSize.max,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('REMARKS', style: const pw.TextStyle(fontSize: 8.0)),
                pw.Text(remarks!, style: const pw.TextStyle(fontSize: 8.0))
              ],
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.BarcodeWidget(
              color: PdfColor.fromHex("#000000"),
              barcode: pw.Barcode.code128(),
              data: barCode!,
              drawText: false,
              height: 25,
              width: 300,
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.Text(
              'INVOICE DETAILS',
              textAlign: pw.TextAlign.center,
              style:
                  pw.TextStyle(fontSize: 11.0, fontWeight: pw.FontWeight.bold),
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            // Table
            pw.Container(
              child: table,
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0), // Example
              child: pw.Row(
                mainAxisSize: pw.MainAxisSize.max,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'Total',
                      textAlign: pw.TextAlign.left,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      invoiceTotal!
                          .toStringAsFixed(2), // Format to 2 decimal places
                      textAlign: pw.TextAlign.right,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: pw.Row(
                mainAxisSize: pw.MainAxisSize.max,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'Discount',
                      textAlign: pw.TextAlign.left,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      invoiceTotalDiscount!
                          .toStringAsFixed(2), // Format to 2 decimal places
                      textAlign: pw.TextAlign.right,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ),
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.Padding(
              padding: const pw.EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: pw.Row(
                mainAxisSize: pw.MainAxisSize.max,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'Net Total',
                      textAlign: pw.TextAlign.left,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      invoiceTotalNet!
                          .toStringAsFixed(2), // Format to 2 decimal places
                      textAlign: pw.TextAlign.right,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: pw.Row(
                mainAxisSize: pw.MainAxisSize.max,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'Paid Amt',
                      textAlign: pw.TextAlign.left,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      paidAmount!
                          .toStringAsFixed(2), // Format to 2 decimal places
                      textAlign: pw.TextAlign.right,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ),
            ),
            pw.Divider(height: 5.0, thickness: 0.5, color: PdfColors.black),
            pw.Padding(
              padding: const pw.EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: pw.Row(
                mainAxisSize: pw.MainAxisSize.max,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'Unpaid Amt',
                      textAlign: pw.TextAlign.left,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      unPaidAmount!
                          .toStringAsFixed(2), // Format to 2 decimal places
                      textAlign: pw.TextAlign.right,
                      style: const pw.TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0), // Example
              child: pw.Text(
                invoiceConditionsEn!,
                textAlign: pw.TextAlign.center,
              ),
            ),
          ],
        );
      },
    ),
  );

  final Uint8List pdfBytes = await pdf.save();
  final tempDir = await getTemporaryDirectory();
  final tempFile = File('${tempDir.path}/temp.pdf');
  await tempFile.writeAsBytes(pdfBytes);

  final pdfconvToImage = PdfImageRendererPdf(path: '${tempDir.path}/temp.pdf');

/*
/////// PRINT ///////
  final directprintPlugin = Directprint();

  // ...

  Uint8List enctxt = pdfBytes;

  String printer = 'EPSON TM-T88V Receipt';
  String job = 'Invoice';

  String dpResult = await directprintPlugin.print(printer, job, enctxt) ?? '';
  /////// PRINT /////// END
*/
  return FFUploadedFile(bytes: pdfBytes, name: "invoice" + ".pdf");
}
