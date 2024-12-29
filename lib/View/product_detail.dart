import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xmark/Data/products.dart';
import 'package:xmark/Utils/styles.dart';
import 'package:xmark/View/dashboard.dart';
import 'package:xmark/Viwe%20Model/estimation_provider.dart';
import 'package:xmark/Widgets/appBar.dart';
import 'package:xmark/Widgets/button.dart';
import 'package:xmark/Widgets/container.dart';

class ProductDetails extends StatefulWidget {
  final String name;
  final String narration;
  final int price;
  final int qty;
  final int discountRate;
  final int dividerqty;
  final int checkqty;
  final int archqty;
  final int loowerqty;
  const ProductDetails({
    super.key,
    required this.name,
    required this.narration,
    required this.price,
    required this.qty,
    required this.dividerqty,
    required this.checkqty,
    required this.archqty,
    required this.loowerqty,
    required this.discountRate,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController productDiscountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final estimationProvider = Provider.of<Estimation>(context, listen: false);
    estimationProvider.assignQty(
      pqty: widget.qty,
      pdividerqty: widget.dividerqty,
      pcheckqty: widget.checkqty,
      parchqty: widget.archqty,
      ploowerqty: widget.loowerqty,
      pdiscountRate: widget.discountRate,
    );
  }

  @override
  void dispose() {
    super.dispose();
    productDiscountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final estimationProvider = Provider.of<Estimation>(context, listen: false);

    return Scaffold(
      backgroundColor: scafoldBackGroundColor,
      appBar: customAppBar('Product Details', true, context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox(height * 0.04, width),
            CustomContainer(
              width: width,
              color: Colors.white,
              padding: EdgeInsets.all(height * 0.03),
              margin: EdgeInsets.symmetric(horizontal: width * 0.04),
              borderRadius: BorderRadius.circular(10),
              boxshaw: [leftBoxShadow, rightBoxShadow],
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
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
                                estimationProvider.incrementQty("product", widget.price);
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
                  sizedBox(height * 0.01, width),
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: Row(
                        children: [
                          Text(
                              [
                                'Narration',
                                'Price',
                                'Gross Amount',
                                'Discount',
                                'Total Amount',
                              ][index],
                              style: blackLargeTextStyle),
                          const Spacer(),
                          index != 3
                              ? Consumer<Estimation>(
                                  builder: (context, person, child) {
                                    estimationProvider.setCalculatePrice(widget.price);
                                    estimationProvider.calculatingProductTotalAmount();
                                    return Text(
                                      [
                                        widget.narration,
                                        '${estimationProvider.price}.00',
                                        '${person.qty * estimationProvider.price}.00',
                                        "",
                                        "${person.productTotalAmount}.00",
                                      ][index],
                                      style: index == 4 ? blackLargeBoldTextStyle : blackLargeTextStyle,
                                    );
                                  },
                                )
                              : SizedBox(
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
                                ),
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
              padding: EdgeInsets.symmetric(horizontal: width * 0.04,vertical: height * 0.04),
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
                                      ));
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
                          name: widget.name,
                          qty: estimationProvider.qty,
                          narration: widget.narration,
                          price: estimationProvider.price,
                          grossAmount: estimationProvider.qty * estimationProvider.price,
                          discount: estimationProvider.productDiscountAmount,
                          totalPrice: estimationProvider.productTotalAmount,
                        );
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false);
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

/////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
Widget decrementButton({required height, required width, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: CustomContainer(
      height: height * 0.048,
      width: width * 0.12,
      color: const Color.fromARGB(255, 255, 118, 118),
      borderRadius: BorderRadius.circular(8),
      child: const Center(
        child: Icon(Icons.remove, color: Colors.white),
      ),
    ),
  );
}

/////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
Widget increamentButton({required height, required width, required onTap}) {
  return InkWell(
    onTap: onTap,
    child: CustomContainer(
      height: height * 0.048,
      width: width * 0.12,
      color: Colors.lightBlueAccent.shade100,
      borderRadius: BorderRadius.circular(8),
      child: const Center(
        child: Icon(Icons.add, color: Colors.white),
      ),
    ),
  );
}

/////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
Widget qtyShowBox({required height, required width, required text}) {
  return CustomContainer(
    height: height * 0.04,
    width: width * 0.3,
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    child: Center(
      child: Text(text, style: blackMediumTextStyle),
    ),
  );
}
