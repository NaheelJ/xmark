import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xmark/Data/products.dart';
import 'package:xmark/Utils/styles.dart';
import 'package:xmark/View/dashboard.dart';
import 'package:xmark/View/product_detail.dart';
import 'package:xmark/Viwe%20Model/estimation_provider.dart';
import 'package:xmark/Widgets/appBar.dart';
import 'package:xmark/Widgets/button.dart';
import 'package:xmark/Widgets/container.dart';

class ManualAdding extends StatefulWidget {
  const ManualAdding({super.key});

  @override
  State<ManualAdding> createState() => _ManualAddingState();
}

class _ManualAddingState extends State<ManualAdding> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productLengthController = TextEditingController();
  TextEditingController productWidthController = TextEditingController();
  TextEditingController productNarrationPriceController = TextEditingController();
  TextEditingController productDiscountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final estimationProvider = Provider.of<Estimation>(context, listen: false);
    estimationProvider.manualAssignZeroToAll();
    estimationProvider.assignQty(
      pqty: 1,
      pdividerqty: 0,
      pcheckqty: 0,
      parchqty: 0,
      ploowerqty: 0,
      pdiscountRate: 0,
    );
    productNameController.clear();
    productLengthController.clear();
    productWidthController.clear();
    productDiscountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final estimationProvider = Provider.of<Estimation>(context, listen: false);
    return Scaffold(
      backgroundColor: scafoldBackGroundColor,
      appBar: customAppBar('Manual', true, context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox(height * 0.04, width),
            CustomContainer(
              width: width,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.03),
              margin: EdgeInsets.symmetric(horizontal: width * 0.04),
              borderRadius: BorderRadius.circular(10),
              boxshaw: [leftBoxShadow, rightBoxShadow],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product Name",
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: 1,
                            ),
                          ),
                          sizedBox(height * 0.01, 0.0),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.4,
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: productNameController,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                letterSpacing: 1,
                              ),
                              keyboardType: TextInputType.name,
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                  letterSpacing: 1,
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade500)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade500)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade500)),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                contentPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomContainer(
                        height: height * 0.055,
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          children: [
                            sizedBox(0.0, width * 0.015),
                            InkWell(
                              onTap: () {
                                estimationProvider.decrementQty("product");
                              },
                              child: CustomContainer(
                                height: height * 0.04,
                                width: width * 0.08,
                                color: const Color.fromARGB(255, 255, 95, 95),
                                borderRadius: BorderRadius.circular(8),
                                child: const Center(
                                  child: Icon(Icons.remove, color: Colors.white),
                                ),
                              ),
                            ),
                            sizedBox(0.0, width * 0.025),
                            CustomContainer(
                              height: height * 0.04,
                              width: width * 0.12,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              child: Center(
                                child: Consumer<Estimation>(builder: (context, person, child) {
                                  return Text(
                                    '${person.qty}',
                                    style: blackMediumBoldTextStyle,
                                  );
                                }),
                              ),
                            ),
                            sizedBox(0.0, width * 0.025),
                            InkWell(
                              onTap: () {
                                estimationProvider.incrementQty("product", 10);
                              },
                              child: CustomContainer(
                                height: height * 0.04,
                                width: width * 0.08,
                                color: Colors.lightBlueAccent.shade100,
                                borderRadius: BorderRadius.circular(8),
                                child: const Center(
                                  child: Icon(Icons.add, color: Colors.white),
                                ),
                              ),
                            ),
                            sizedBox(0.0, width * 0.015),
                          ],
                        ),
                      ),
                    ],
                  ),
                  sizedBox(height * 0.04, width),
                  Text(
                    "Narration",
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  sizedBox(height * 0.01, 0.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) => SizedBox(
                        height: height * 0.05,
                        width: index == 2 ? width * 0.3 : width * 0.25,
                        child: TextField(
                          controller: [productLengthController, productWidthController, productNarrationPriceController][index],
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: 1.5,
                          ),
                          keyboardType: TextInputType.number,
                          onSubmitted: index == 2
                              ? (value) {
                                  estimationProvider.setNarrationPrice(value);
                                }
                              : (value) {
                                  estimationProvider.calculateNarrationPrice(
                                    kwidth: productWidthController.text,
                                    klength: productLengthController.text,
                                  );
                                  productNarrationPriceController = TextEditingController(text: estimationProvider.narrationPrice.toString());
                                },
                          onTapOutside: index == 2
                              ? (event) {
                                  FocusScope.of(context).unfocus();
                                  estimationProvider.setNarrationPrice(productNarrationPriceController.text);
                                }
                              : (event) {
                                  FocusScope.of(context).unfocus();
                                  estimationProvider.calculateNarrationPrice(
                                    kwidth: productWidthController.text,
                                    klength: productLengthController.text,
                                  );
                                  productNarrationPriceController = TextEditingController(text: estimationProvider.narrationPrice.toString());
                                },
                          decoration: InputDecoration(
                            labelText: ["Length", "Width", ""][index],
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: index == 2 ? 14 : 12,
                              fontWeight: index == 2 ? FontWeight.w500 : FontWeight.w400,
                              color: index == 2 ? Colors.black : Colors.grey.shade600,
                              letterSpacing: 1,
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade500)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade500)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade500)),
                            floatingLabelBehavior: index == 2 ? FloatingLabelBehavior.never : FloatingLabelBehavior.auto,
                            contentPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedBox(height * 0.03, width),
                  divider,
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
                      child: Row(
                        children: [
                          Text(
                              [
                                'Price',
                                'Gross Amount',
                                'Discount',
                                'Total Amount',
                              ][index],
                              style: blackMediumTextStyle),
                          const Spacer(),
                          index == 2
                              ? SizedBox(
                                  height: height * 0.045,
                                  width: width * 0.3,
                                  child: TextField(
                                    controller: productDiscountController,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      letterSpacing: 1,
                                    ),
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (value) {
                                      estimationProvider.setDiscountProducts(value);
                                    },
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                      estimationProvider.setDiscountProducts(productDiscountController.text);
                                    },
                                    decoration: InputDecoration(
                                      labelText: "discount",
                                      labelStyle: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        letterSpacing: 1,
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade500)),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade500)),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade500)),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04),
                                    ),
                                  ),
                                )
                              : Consumer<Estimation>(
                                  builder: (context, person, child) {
                                    estimationProvider.setCalculatePrice(estimationProvider.narrationPrice);
                                    estimationProvider.calculatingProductTotalAmount();
                                    return Text(
                                      [
                                        '${estimationProvider.price}.00',
                                        '${person.qty * estimationProvider.price}.00',
                                        "",
                                        "${person.productTotalAmount}.00",
                                      ][index],
                                      style: index == 3 ? blackLargeBoldTextStyle : blackLargeTextStyle,
                                    );
                                  },
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            sizedBox(height * 0.02, width),
            CustomContainer(
              width: width,
              color: Colors.white,
              padding: EdgeInsets.all(height * 0.03),
              margin: EdgeInsets.symmetric(horizontal: width * 0.04),
              borderRadius: BorderRadius.circular(10),
              boxshaw: [leftBoxShadow, rightBoxShadow],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Additional Items ///////////////////////////////////////////////////////////////////////////
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: height * 0.025),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                ['Divider', 'Check', 'Arch', 'Loower'][index],
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  letterSpacing: 1,
                                ),
                              ),
                              const Spacer(),
                              Consumer<Estimation>(
                                builder: (context, person, child) {
                                  return Text(
                                    [
                                      'Rs  ${person.dividerQty * kdividerPrice}.00',
                                      'Rs  ${person.checkQty * kcheckPrice}.00',
                                      'Rs  ${person.archQty * karchPrice}.00',
                                      'Rs  ${person.loowerQty * kloowerPrice}.00',
                                    ][index],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      letterSpacing: 1,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          sizedBox(height * 0.005, 0.0),
                          CustomContainer(
                            height: height * 0.066,
                            width: width,
                            color: Colors.orange.shade50,
                            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                decrementButton(
                                    height: height,
                                    width: width,
                                    onTap: [
                                      () {
                                        estimationProvider.decrementQty("divider");
                                      },
                                      () {
                                        estimationProvider.decrementQty("check");
                                      },
                                      () {
                                        estimationProvider.decrementQty("arch");
                                      },
                                      () {
                                        estimationProvider.decrementQty("loower");
                                      },
                                    ][index]),
                                Consumer<Estimation>(
                                  builder: (context, person, child) => qtyShowBox(
                                    height: height,
                                    width: width,
                                    text: [
                                      '${person.dividerQty}',
                                      '${person.checkQty}',
                                      '${person.archQty}',
                                      '${person.loowerQty}',
                                    ][index],
                                  ),
                                ),
                                increamentButton(
                                  height: height,
                                  width: width,
                                  onTap: [
                                    () {
                                      estimationProvider.incrementQty("divider");
                                    },
                                    () {
                                      estimationProvider.incrementQty("check");
                                    },
                                    () {
                                      estimationProvider.incrementQty("arch");
                                    },
                                    () {
                                      estimationProvider.incrementQty("loower");
                                    }
                                  ][index],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBox(height * 0.025, width),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                    child: BlueElevatedButton(
                      text: 'Submit',
                      width: width,
                      onpressed: () {
                        estimationProvider.addToSelectedProducts(
                          name: productNameController.text,
                          qty: estimationProvider.qty,
                          narration: "${productWidthController.text} x ${productLengthController.text}",
                          price: estimationProvider.price,
                          grossAmount: estimationProvider.qty * estimationProvider.price,
                          discount: estimationProvider.productDiscountAmount,
                          totalPrice: estimationProvider.productTotalAmount,
                        );
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route) => false);
                      },
                    ),
                  ),
                  sizedBox(height * 0.01, width),
                ],
              ),
            ),
            sizedBox(height * 0.04, width),
          ],
        ),
      ),
    );
  }
}
