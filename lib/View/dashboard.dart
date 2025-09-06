import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xmark/Utils/styles.dart';
import 'package:xmark/View/estimation_detailes.dart';
import 'package:xmark/View/manual_adding.dart';
import 'package:xmark/View/my_products.dart';
import 'package:xmark/Viwe%20Model/estimation_provider.dart';
import 'package:xmark/Widgets/appBar.dart';
import 'package:xmark/Widgets/button.dart';
import 'package:xmark/Widgets/container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<Estimation>(context, listen: false);
    return Scaffold(
      backgroundColor: scafoldBackGroundColor,
      appBar: dashBoardAppBar,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox(height * 0.015, width),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      provider.clearAllProductsList(context);
                      provider.discount = 0;
                    },
                    child: Consumer<Estimation>(
                      builder: (context, person, child) {
                        person.getSelectedProducts();

                        return CustomContainer(
                          boxshaw: [leftBoxShadow],
                          borderRadius: BorderRadius.circular(5),
                          padding: EdgeInsets.symmetric(horizontal: width * 0.025, vertical: height * 0.008),
                          color: person.selectedProducts.isEmpty && person.discount == 0 ? Colors.redAccent.shade100 : Colors.redAccent.shade200,
                          child: Text(
                            'Clear all',
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              sizedBox(height * 0.02, width),
              Consumer<Estimation>(
                builder: (context, person, child) => Visibility(
                  visible: provider.selectedProducts.isEmpty,
                  child: SizedBox(
                    height: height * 0.42,
                  ),
                ),
              ),
              Consumer<Estimation>(
                builder: (context, person, child) => ListView.builder(
                  itemCount: person.selectedProducts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CustomContainer(
                      width: width,
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: height * 0.02, left: width * 0.01, right: width * 0.01),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.025),
                      borderRadius: BorderRadius.circular(15),
                      boxshaw: [
                        leftBoxShadow,
                      ],
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  provider.deleteProduct(index);
                                },
                                child: Text(
                                  'Delete',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizedBox(height * 0.005, width),
                          Divider(color: Colors.grey.shade200),
                          ///////////////////////////////////////////////////////////////////////
                          sizedBox(height * 0.015, width),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, i) => Padding(
                              padding: EdgeInsets.only(bottom: height * 0.008),
                              child: Row(
                                children: [
                                  Text(i == 0 ? '${index + 1}.  ' : "", style: blackMediumTextStyle),
                                  Text(
                                      [
                                        provider.selectedProducts[index]['name'],
                                        'Narration',
                                        'Price',
                                        'Gross Amount',
                                        'Discount',
                                      ][i],
                                      style: i == 0 ? blackMediumBoldTextStyle : blackMediumTextStyle),
                                  const Spacer(),
                                  Text(
                                      [
                                        'Qty',
                                        provider.selectedProducts[index]['narration'],
                                        '${provider.selectedProducts[index]['price']}.00',
                                        '${provider.selectedProducts[index]['grossAmount']}.00',
                                        '${provider.selectedProducts[index]['discount']}.00'
                                      ][i],
                                      style: blackMediumTextStyle),
                                  sizedBox(0.0, i == 0 ? width * 0.03 : 0.0),
                                  Text(i == 0 ? '${provider.selectedProducts[index]['quantity']}' : "", style: blackMediumBoldTextStyle),
                                  sizedBox(0.0, width * 0.01)
                                ],
                              ),
                            ),
                          ),
                          provider.selectedProducts[index]['additional'].isEmpty
                              ? SizedBox(height: height * 0.01)
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: height * 0.015),
                                  child: CustomContainer(
                                    width: width,
                                    padding: const EdgeInsets.all(10),
                                    color: Colors.orange.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    child: Column(
                                      children: List.generate(
                                        provider.selectedProducts[index]['additional'].length,
                                        (mindex) => Row(
                                          children: [
                                            ///////////////////////////////////////////////////////////////////////////////
                                            SizedBox(
                                              width: width * 0.4,
                                              child: Text(
                                                provider.selectedProducts[index]['additional'][mindex]['label'],
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text('${provider.selectedProducts[index]['additional'][mindex]['qty']}', style: blackMediumTextStyle),
                                            const Spacer(),
                                            Text('${provider.selectedProducts[index]['additional'][mindex]['price']}', style: blackMediumTextStyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          divider,
                          sizedBox(height * 0.005, width),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //////////////////////////////////////////////////////////////////////////////////////
                              Text('Total Price', style: blackMediumTextStyle),
                              Text('${provider.selectedProducts[index]['totalPrice']}.00', style: blackMediumBoldTextStyle),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              sizedBox(height * 0.01, width),
              CustomContainer(
                width: width,
                color: primaryColor,
                margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                padding: EdgeInsets.symmetric(vertical: height * 0.025, horizontal: width * 0.04),
                borderRadius: BorderRadius.circular(15),
                boxshaw: [
                  leftBoxShadow,
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Product Details', style: blackMediumBoldTextStyle),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            showBottomSheetOfEditDiscountAmount(
                              context: context,
                            );
                          },
                          child: Text(
                            "Edit",
                            style: GoogleFonts.montserrat(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizedBox(height * 0.005, width),
                    divider,
                    sizedBox(height * 0.01, width),
                    Row(
                      children: [
                        Text('Gross', style: blackMediumTextStyle),
                        const Spacer(),
                        Consumer<Estimation>(
                          builder: (context, person, child) {
                            person.calculatingGrossAmount();
                            return Text('${person.grossAmount}', style: blackMediumBoldTextStyle);
                          },
                        ),
                      ],
                    ),
                    sizedBox(height * 0.01, width),
                    Row(
                      children: [
                        Text('Total Discount', style: blackMediumTextStyle),
                        const Spacer(),
                        Consumer<Estimation>(
                          builder: (context, person, child) {
                            return Text('${person.discount}', style: blackMediumBoldTextStyle);
                          },
                        ),
                      ],
                    ),
                    sizedBox(height * 0.01, width),
                    divider,
                    sizedBox(height * 0.01, width),
                    Row(
                      children: [
                        Text(
                          'Grand Total Amount',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        Consumer<Estimation>(
                          builder: (context, person, child) {
                            person.calculatingGrandTotalAmount();
                            return Text('${person.grandTotalAmount}', style: blackMediumBoldTextStyle);
                          },
                        ),
                      ],
                    ),
                    sizedBox(height * 0.01, width),
                    divider,
                    sizedBox(height * 0.02, width),
                    Center(
                      child: BlueElevatedButton(
                        text: 'Generate Invoice',
                        onpressed: () async {
                          if (provider.selectedProducts.isNotEmpty) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EstimationDetailes()));
                          }
                        },
                        width: width * 0.82,
                      ),
                    ),
                    sizedBox(height * 0.005, width),
                  ],
                ),
              ),
              sizedBox(height * 0.06, width)
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (int i = 0; i < 2; i++)
            Padding(
              padding: EdgeInsets.only(bottom: [height * 0.02, 0.0][i]),
              child: FloatingActionButton(
                backgroundColor: [Colors.orangeAccent.shade100, Colors.deepPurpleAccent.shade100][i],
                mini: [true, false][i],
                heroTag: 'fab-$i',
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: [
                  () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ManualAdding()));
                  },
                  () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProducts()));
                  }
                ][i],
                child: Icon([Icons.edit, Icons.add][i], color: Colors.white, size: <double>[20, 29][i]),
              ),
            ),
        ],
      ),
    );
  }
}

Future<dynamic> showBottomSheetOfEditDiscountAmount({
  required BuildContext context,
}) {
  final provider = Provider.of<Estimation>(context, listen: false);
  TextEditingController discountOfAllProducts = TextEditingController();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Title
            Text(
              'Discount',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 16),

            // Input Field
            CustomTextField(
              controller: discountOfAllProducts,
              textInputType: TextInputType.number,
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size.fromHeight(45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      discountOfAllProducts.clear();
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.montserrat(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      fixedSize: Size.fromHeight(45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      provider.setDiscountOfListOfProducts(
                        discountOfAllProducts.text,
                      );
                      Navigator.of(context).pop();
                      discountOfAllProducts.clear();
                    },
                    child: Text(
                      'Proceed',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
