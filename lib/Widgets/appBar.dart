import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmark/Utils/styles.dart';
import 'package:xmark/Widgets/button.dart';

AppBar dashBoardAppBar = AppBar(
  backgroundColor: appBarColor,
  surfaceTintColor: appBarColor,
  centerTitle: true,
  title: Text(
    'Xmark',
    style: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 1,
    ),
  ),
);

//////////////////////////////////////////////////////////////////////////////////////
/// Custom AppBar
///
AppBar customAppBar(text, bool isbackbutton, context) {
  return AppBar(
    backgroundColor: appBarColor,
    surfaceTintColor: appBarColor,
    title: Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
    leading: isbackbutton ? backArrowButton(context) : const SizedBox(),
    leadingWidth: isbackbutton ? null : 10,
  );
}
