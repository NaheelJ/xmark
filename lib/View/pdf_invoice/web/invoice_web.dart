import 'dart:typed_data';
import 'dart:html' as html;

void displayPdf(Uint8List pdfData) {
  final blob = html.Blob([pdfData], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);

  // Create an anchor element to enable downloading with a custom file name
  final anchor = html.AnchorElement(href: url)
    ..target = '_blank'
    ..download = "Sales Estimation.pdf"; // Set the custom file name
  anchor.click(); // Programmatically click the anchor to trigger the download

  // Revoke the object URL when no longer needed
  html.Url.revokeObjectUrl(url);
}