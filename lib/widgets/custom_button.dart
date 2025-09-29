import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zetstron/themes/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final double height;
  // final double width;
  final Color? color;
  final BoxBorder? border;
  final String title;
  final Color? textColor;
  final String icon;
  final EdgeInsetsGeometry padding;
  final Color? iconColor;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.height,
    // required this.width,
    required this.color,
    required this.border,
    required this.title,
    required this.textColor,
    required this.icon,
    required this.padding,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        // width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: border,
        ),
        child: Padding(
          padding: padding,
          child: Row(
            spacing: 13,
            children: [
              AutoSizeText(
                title,
                style: AppTextStyle.buttonTextStyle(color: textColor),
              ),
              SvgPicture.asset(icon, color: iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
