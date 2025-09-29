import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;

  final Color? color;
  final Gradient? gradient;
  final Widget? child;
  final EdgeInsetsGeometry padding;

  const CustomContainer({
    super.key,
    this.child,
    this.color,
    this.gradient,
    this.height,
    this.width,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
