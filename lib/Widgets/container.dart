import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final Gradient? gradiantcolor;
  final String? image;
  final List<BoxShadow>? boxshaw;
  final Widget? child;

  const CustomContainer({
    super.key,
    this.height,
    this.width,
    required this.color,
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
    this.gradiantcolor,
    this.image,
    this.boxshaw,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border,
        gradient: gradiantcolor,
        image:
            image != null ? DecorationImage(image: AssetImage(image!)) : null,
        boxShadow: boxshaw,
      ),
      child: child,
    );
  }
}
