import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';

import 'package:xmark/View/pdf_invoice/invoice_design.dart';

Future<Uint8List> generatePdf({
  required String partyName,
  required String address,
  required String mobileNumber,
  required String remark,
  required double grossAmount,
  required double totalDiscount,
  required double grandTotalAmount,
  required List selectedProducts,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(20),
      build: (context) => pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(width: 0.5, color: PdfColors.black),
        ),
        padding: const pw.EdgeInsets.all(10),
        child: pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(height: 15),
            pw.Center(
              child: pw.Text(
                'SALES ESTIMATION',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 25),

            // Header Information
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: 350,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: List.generate(
                      3,
                      (index) => pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5),
                        child: pw.Row(children: [
                          pw.SizedBox(
                            width: 80,
                            child: pw.Text(['Party Name', "Address", "Mobile"][index], style: const pw.TextStyle(fontSize: 10)),
                          ),
                          pw.Text(':', style: const pw.TextStyle(fontSize: 10)),
                          pw.SizedBox(width: 10),
                          pw.Text([partyName, address, mobileNumber][index], style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ),
                    ),
                  ),
                ),
                pw.Container(
                  width: 160,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: List.generate(
                      2,
                      (index) => pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5),
                        child: pw.Row(children: [
                          pw.SizedBox(
                            width: 70,
                            child: pw.Text(['Voucher No', 'Voucher Date'][index], style: const pw.TextStyle(fontSize: 10)),
                          ),
                          pw.Text(':', style: const pw.TextStyle(fontSize: 10)),
                          pw.SizedBox(width: 20),
                          pw.Text(
                              [
                                '',
                                (DateFormat('dd-MM-yyyy').format(DateTime.now())),
                              ][index],
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 10),

            pw.Row(
              children: [
                pw.SizedBox(
                  width: 80,
                  child: pw.Text('Remark', style: const pw.TextStyle(fontSize: 10)),
                ),
                pw.Text(':', style: const pw.TextStyle(fontSize: 10)),
                pw.SizedBox(width: 10),
                // Remark Section
                pw.Container(
                  width: 300,
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.black,
                    ),
                  ),
                  child: pw.Text(remark, style: const pw.TextStyle(fontSize: 10)),
                ),
              ],
            ),

            pw.SizedBox(height: 10),

            // Table
            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: const pw.FixedColumnWidth(30),
                1: const pw.FixedColumnWidth(100),
                2: const pw.FlexColumnWidth(),
                3: const pw.FixedColumnWidth(40),
                4: const pw.FixedColumnWidth(40),
                5: const pw.FixedColumnWidth(70),
                6: const pw.FixedColumnWidth(70),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.white),
                  children: [
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Sl', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('DProductName', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Narration', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('DQty', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('DUnit', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('DRate', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('DNetAmount', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold))),
                  ],
                ),

                // Dynamic Rows
                ...buildTableRows(selectedProducts),
              ],
            ),

            pw.SizedBox(height: 15),
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Amount in Words
                  pw.Text('Amount In Words :', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 10),
                  pw.Text('India Rupee ${numberToWords(grandTotalAmount)}', style: const pw.TextStyle(fontSize: 10)),
                ],
              ),

              // Footer
              pw.Container(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: List.generate(
                    3,
                    (index) => pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 3),
                      child: pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 80,
                            child: pw.Text(['Gross', 'Total Discount', 'Grand Total'][index], style: pw.TextStyle(fontSize: 10, fontWeight: index == 2 ? pw.FontWeight.bold : pw.FontWeight.normal)),
                          ),
                          pw.Text(':', style: const pw.TextStyle(fontSize: 10)),
                          pw.SizedBox(width: 40),
                          pw.Text(['$grossAmount', "$totalDiscount", "$grandTotalAmount"][index], style: const pw.TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            pw.Divider(color: PdfColors.grey300),

            // Terms and Conditions
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: List.generate(
                3,
                (index) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 3),
                  child: pw.Text(
                    ['Terms & Conditions:', 'Delivery: Within 15 Days after receiving order confirmation', 'Payment: 50% Advance payment & Balance 50% on delivery'][index],
                    style: pw.TextStyle(fontSize: 10, fontWeight: index == 0 ? pw.FontWeight.bold : pw.FontWeight.normal),
                  ),
                ),
              ),
            ),

            pw.SizedBox(height: 20),

            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text('Authorised Signatory', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            ),
          ],
        ),
      ),
    ),
  );

  return pdf.save();
}
