import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///////////////////////////////////////////////////////////////////////////////////////////
/// Colors
///
/// - Scafold Background Color
/// - AppBar Background Color
///
Color scafoldBackGroundColor = Colors.grey.shade100;
const Color appBarColor = Color.fromARGB(255, 255, 219, 90);
const Color primaryColor = Colors.white;
Color additionalItemsBoxColors = Colors.orange.shade50;

///////////////////////////////////////////////////////////////////////////////////////////
/// TextStyle
///
/// - Black Medium TextStyle
/// - Black Medium Bold TextStyle
/// - Black Small TextStyle
/// - Black Large TextStyle
/// - Black Medium TextStyle
/// - Black Medium Bold TextStyle
/// - Black Small TextStyle
/// - Black Small Bold TextStyle

TextStyle blackSmallTextStyle = GoogleFonts.montserrat(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.black,
  letterSpacing: 1,
);


TextStyle blackMediumTextStyle = GoogleFonts.montserrat(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.black,
  letterSpacing: 1,
);

TextStyle blackMediumBoldTextStyle = GoogleFonts.montserrat(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black,
  letterSpacing: 1,
);

TextStyle blackLargeTextStyle = GoogleFonts.montserrat(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

TextStyle blackLargeBoldTextStyle = GoogleFonts.montserrat(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

///////////////////////////////////////////////////////////////////////////////////////////////
/// Custom Sized Box
///
/// Parameters
///
/// - Height
/// - Width
///
Widget sizedBox(height, width) {
  return SizedBox(
    height: height,
    width: width,
  );
}

/////////////////////////////////////////////////////////////////////////////////////////////
/// Divider
///
Divider divider = Divider(
  thickness: 1,
  color: Colors.grey.shade400,
);

/////////////////////////////////////////////////////////////////////////////////////////////
/// Box Shadow
///
/// - Left Box Shadow
/// - Right Box Shadow
///
final BoxShadow leftBoxShadow = BoxShadow(blurRadius: 0.3, color: Colors.grey.shade200, offset: const Offset(-2, 2));

final BoxShadow rightBoxShadow = BoxShadow(blurRadius: 0.3, color: Colors.grey.shade200, offset: const Offset(2, -2));

final additionalItemsName = [
  'Divide',
  'Check',
  'Arch',
  'Loower',
];
