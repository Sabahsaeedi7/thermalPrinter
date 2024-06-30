// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';
// Add this for Colors

class FFUploadedFile {
  final String name;
  final String path;
  final Uint8List bytes;

  FFUploadedFile({required this.name, required this.path, required this.bytes});
}

Future<FFUploadedFile> convertPdfToImage(FFUploadedFile pdfFile) async {
  try {
    // 1. Create temporary files for PDF and image
    final tempDir = await getTemporaryDirectory();
    final tempPdfFile = File('${tempDir.path}/temp.pdf');
    final tempImageFile =
        File('${tempDir.path}/temp.png'); // Adjust image format if needed

    // 2. Write PDF bytes to the temporary PDF file
    await tempPdfFile.writeAsBytes(pdfFile.bytes);

    // 3. Initialize renderer with temporary PDF file path
    final pdf = PdfImageRendererPdf(path: tempPdfFile.path);
    await pdf.open();

    // 4. Get page size (assuming you want the first page)
    final size = await pdf.getPageSize(pageIndex: 0);

    // 5. Render the page
    final img = await pdf.renderPage(
      pageIndex: 0,
      x: 0,
      y: 0,
      width: size.width,
      height: size.height,
      scale: 1,
      background: Colors.white,
    );

    // 6. Save the rendered image to the temporary image file
    await tempImageFile.writeAsBytes(img!);

    // 7. Close resources
    await pdf.closePage(pageIndex: 0);
    pdf.close();

    // 8. Read the bytes from the temporary image file
    final imageBytes = await tempImageFile.readAsBytes();

    // 9. Delete the temporary PDF and image files (image bytes are what we return)
    await tempPdfFile.delete();
    await tempImageFile.delete();

    // 10. Return the FFUploadedFile object with image data
    return FFUploadedFile(
      name: 'temp.png',
      path: tempImageFile.path,
      bytes: imageBytes,
    );
  } catch (e) {
    print("Error converting PDF to image: $e");
    rethrow; // Re-throw the error to be handled by the caller
  }
}
