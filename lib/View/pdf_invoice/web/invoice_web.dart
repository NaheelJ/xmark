import 'dart:typed_data';
import 'dart:html' as html;

void displayPdf(Uint8List pdfData) {
  final blob = html.Blob([pdfData], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  
  // Open the PDF in a new browser tab
  html.window.open(url, '_blank');
  
  // Revoke the object URL when no longer needed
  html.Url.revokeObjectUrl(url);
}