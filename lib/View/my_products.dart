import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmark/Data/products.dart';
import 'package:xmark/Utils/styles.dart';
import 'package:xmark/View/product_detail.dart';
import 'package:xmark/Widgets/appBar.dart';
import 'package:xmark/Widgets/container.dart';

class MyProducts extends StatelessWidget {
   const MyProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scafoldBackGroundColor,
      appBar: customAppBar('My Products', true, context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox(height * 0.03, width),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              itemCount: myProducts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            name: myProducts[index].name,
                            narration: myProducts[index].narration,
                            price: myProducts[index].price,
                            qty: 1,
                            discountRate: 0,
                            dividerqty: 0,
                            checkqty: 0,
                            archqty: 0,
                            loowerqty: 0,
                          ),
                        ),
                      );
                    },
                    child: CustomContainer(
                      height: height * 0.11,
                      width: width,
                      color: Colors.white,
                      padding: EdgeInsets.all(height * 0.02),
                      borderRadius: BorderRadius.circular(10),
                      boxshaw: [
                        leftBoxShadow,
                      ],
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('${index + 1}. ', style: blackMediumTextStyle),
                                  sizedBox(0.0, width * 0.004),
                                  Text(
                                    myProducts[index].name,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox(height * 0.005, 0.0),
                              Row(
                                children: [
                                  Text('Narration', style: blackSmallTextStyle),
                                  sizedBox(0.0, width * 0.015),
                                  Text(myProducts[index].narration, style: blackMediumBoldTextStyle),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text('Price', style: blackSmallTextStyle),
                                  sizedBox(0.0, width * 0.02),
                                  Text('Rs.${myProducts[index].price}', style: blackMediumBoldTextStyle),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            sizedBox(height * 0.06, width)
          ],
        ),
      ),
    );
  }
}