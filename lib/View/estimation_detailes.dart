import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xmark/Utils/styles.dart';
import 'package:xmark/View/pdf_invoice/api_hadling.dart';
import 'package:xmark/View/pdf_invoice/invoice_design.dart';
import 'package:xmark/View/pdf_invoice/web/invoice_design.dart';
import 'package:xmark/View/pdf_invoice/web/invoice_web.dart';
import 'package:xmark/Viwe%20Model/estimation_provider.dart';
import 'package:xmark/Viwe%20Model/manual_provider.dart';
import 'package:xmark/Widgets/appBar.dart';
import 'package:xmark/Widgets/button.dart';

class EstimationDetailes extends StatelessWidget {
  const EstimationDetailes({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<Estimation>(context, listen: false);
    final manualProvider = Provider.of<ManualProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: scafoldBackGroundColor,
      appBar: customAppBar("Estimation Details", true, context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.04),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Party Name",
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: height * 0.005),
              CustomTextField(controller: manualProvider.partyNameController, textInputType: TextInputType.name),
              SizedBox(height: height * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Address",
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: height * 0.005),
              CustomTextField(controller: manualProvider.addressController, textInputType: TextInputType.name),
              SizedBox(height: height * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mobile No",
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: height * 0.005),
              CustomTextField(controller: manualProvider.mobileController, textInputType: TextInputType.number),
              SizedBox(height: height * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Remark",
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: height * 0.005),
              SizedBox(
                height: height * 0.15, 
                width: width,
                child: TextField(
                  controller: manualProvider.remarkController,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  maxLines: 10,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF5f3461)),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: height * 0.02, // Adjust vertical padding
                      horizontal: width * 0.04,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: BlueElevatedButton(
            text: 'Continue',
            onpressed: () async {
              /////////////////////////////////////////////////////////////////
              /// For Mobile Application
              /// 
              // final pdfFileMobile = await PdfInvoiceApi.generate(
              //   partyName: manualProvider.partyNameController.text,
              //   address: manualProvider.addressController.text,
              //   mobileNumber: manualProvider.mobileController.text,
              //   remark: manualProvider.remarkController.text,
              //   selectedProducts: provider.selectedProducts,
              //   grossAmount: provider.grossAmount,
              //   totalDiscount: provider.discount,
              //   grandTotalAmount: provider.grandTotalAmount,
              // );
              // // opening the pdf file
              // FileHandleApi.openFile(pdfFileMobile);
              /////////////////////////////////////////////////////////////////
              /// For Web Application
              /// 
              final pdfFileWeb = await generatePdf(
                partyName: manualProvider.partyNameController.text,
                address: manualProvider.addressController.text,
                mobileNumber: manualProvider.mobileController.text,
                remark: manualProvider.remarkController.text,
                selectedProducts: provider.selectedProducts,
                grossAmount: provider.grossAmount,
                totalDiscount: provider.discount,
                grandTotalAmount: provider.grandTotalAmount,
              );
              displayPdf(pdfFileWeb);
            },
            width: width * 0.82,
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  const CustomTextField({super.key, required this.controller, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextField(
      controller: controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF5f3461)),
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.only(left: width * 0.04),
      ),
    );
  }
}