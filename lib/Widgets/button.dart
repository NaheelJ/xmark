import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmark/Utils/styles.dart';

//////////////////////////////////////////////////////////////////////////////////////////////
/// Elevated Button Border
///
/// Parameters
///
/// - text
/// - onPressed
/// - Width
///
class ElevatedButtonBorder extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  final double width;
  const ElevatedButtonBorder({
    super.key,
    required this.text,
    required this.onpressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          fixedSize: Size(width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: Colors.lightBlueAccent.shade100, width: 2.5)),
      onPressed: onpressed,
      child: Text(text, style: blackMediumTextStyle),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////
/// Light Blue Elevated Button
///
/// Parameters
///
/// - text
/// - onPressed
/// - Width
///
class BlueElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  final double width;
  const BlueElevatedButton({
    super.key,
    required this.text,
    required this.onpressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlueAccent.shade100,
        fixedSize: Size(width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onpressed,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////
/// Back Button
///
IconButton backArrowButton(context) {
  return IconButton(
    onPressed: () => Navigator.pop(context),
    icon: const Icon(
      Icons.arrow_back_ios_new,
      color: Colors.white,
    ),
  );
}
