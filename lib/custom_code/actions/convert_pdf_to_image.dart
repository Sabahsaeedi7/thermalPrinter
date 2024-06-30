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
import 'package:pdfx/pdfx.dart';
import 'package:flutter/material.dart'; // Add this for Colors
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:flutter/material.dart'; // Add this for Colors

Future<FFUploadedFile> convertPdfToImage(FFUploadedFile pdfFile) async {
  try {
    // 1. Create temporary files for PDF and image
    final tempDir = await getTemporaryDirectory();
    final tempPdfFile = File('${tempDir.path}/temp.pdf');
    final tempImageFile =
        File('${tempDir.path}/temp.png'); // Adjust image format if needed

    // 2. Write PDF bytes to the temporary PDF file
    await tempPdfFile.writeAsBytes(pdfFile.bytes as List<int>);

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
    final imageBytes = await tempImageFile.readAsBytes();

    // 9. Delete the temporary PDF and image files (image bytes are what we return)
    await tempPdfFile.delete();
    await tempImageFile.delete();

    // 10. Return the FFUploadedFile object with image data
    return FFUploadedFile(
      name: 'temp.png',
      bytes: imageBytes,
    );
  } catch (e) {
    print("Error converting PDF to image: $e");
    rethrow; // Re-throw the error to be handled by the caller
  }
}
