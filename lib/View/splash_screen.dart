import 'package:flutter/material.dart';
import 'package:xmark/Utils/styles.dart';
import 'package:xmark/View/dashboard.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      },
    );
    return Scaffold(
      backgroundColor: appBarColor,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   fit: BoxFit.none,
          //   image: AssetImage("assets/images/splashScreenx.png"),
          // ),
        ),
      ),
    );
  }
}
