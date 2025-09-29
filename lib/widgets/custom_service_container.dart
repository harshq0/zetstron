import 'package:flutter/material.dart';

class CustomServiceContainer extends StatelessWidget {
  final double? height;
  final Gradient? gradient;
  final BoxBorder? border;
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;

  const CustomServiceContainer({
    super.key,
    this.height,
    this.border,
    this.child,
    this.gradient,
    this.borderRadius,
    required this.padding,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
