// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';

Future<String?> printUploadedPdfToThermalPrinter(
    FFUploadedFile? recciptToPrint, String printerIp) async {
  try {
    if (recciptToPrint == null) {
      return 'Error: No PDF file selected.';
    }

    // 1. Get the PDF Bytes from FFUploadedFile
    Uint8List pdfBytes = await recciptToPrint.bytes!;

    // 2. Decode the PDF to an Image
    img.Image? pdfImage;
    try {
      pdfImage = img.decodeImage(pdfBytes);
      if (pdfImage == null) {
        return 'Error: Failed to decode PDF to an image. Make sure the PDF is valid.';
      }
    } catch (e) {
      return "Error decoding PDF: $e";
    }

    // 3. Resize Image for Thermal Printer
    final img.Image resizedImage = img.copyResize(pdfImage, width: 576);
    final img.Image grayscaleImage = img.grayscale(resizedImage);

    // 4. Prepare Printer Connection
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    // 5. Establish Socket Connection and Print
    final PosPrintResult res = await printer.connect(
      printerIp,
      port: 9100,
    );

    if (res == PosPrintResult.success) {
      printer.image(grayscaleImage);
      printer.feed(2);
      printer.cut();
      printer.disconnect();
      return null; // Indicate success
    } else {
      return 'Error connecting to printer: ${res.msg}';
    }
  } catch (e) {
    return 'Error during printing: $e';
  }
}
