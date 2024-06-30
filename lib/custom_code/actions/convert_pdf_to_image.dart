// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image/image.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

import 'package:esc_pos_utils/esc_pos_utils.dart'; // Import ESC/POS utils

Future<FFUploadedFile> convertPdfToImage(FFUploadedFile pdfFile) async {
  try {
    // 1. Create temporary files for PDF and image
    final tempDir = await getTemporaryDirectory();
    final tempPdfFile = File('${tempDir.path}/temp.pdf');
    final tempImageFile =
        File('${tempDir.path}/temp.png'); // Adjust image format if needed

    // 2. Write PDF bytes to the temporary PDF file
    if (pdfFile.bytes == null) {
      throw Exception("PDF file bytes are null");
    }
    await tempPdfFile.writeAsBytes(pdfFile.bytes!);

    // 3. Load the PDF document
    final pdfDocument = await PdfDocument.openFile(tempPdfFile.path);

    // 4. Get the first page
    final page = await pdfDocument.getPage(1);

    // 5. Render the page to an image
    final pageImage = await page.render(
      width: page.width,
      height: page.height,
      format: PdfPageImageFormat.png,
    );

    // 6. Save the rendered image to the temporary image file
    await tempImageFile.writeAsBytes(pageImage!.bytes);

    // 7. Dispose resources
    await page.close();
    await pdfDocument.close();

    // 8. Read the bytes from the temporary image file
    final Uint8List imageBytes = await tempImageFile.readAsBytes();

    // 9. Print the image using a thermal printer
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    final image = decodeImage(imageBytes)!;
    List<int> bytes = [];
    // Connect to the printer and print the data
    final printer = NetworkPrinter(PaperSize.mm80, profile);
    final result = await printer.connect('192.168.178.60', port: 9100);
    if (result == PosPrintResult.success) {
      bytes += generator.image(image);
      bytes += generator.feed(2);
      bytes += generator.cut();
    } else {
      print('Could not connect to printer: $result');
    }

    // 10. Delete the temporary PDF and image files (image bytes are what we return)
    await tempPdfFile.delete();
    await tempImageFile.delete();

    // 11. Return the FFUploadedFile object with image data
    return FFUploadedFile(
      name: 'temp.png',
      bytes: imageBytes,
    );
  } catch (e) {
    print("Error converting PDF to image or printing: $e");
    rethrow; // Re-throw the error to be handled by the caller
  }
}
