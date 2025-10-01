import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle appBarButtonTextStyle({required Color? color}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.manrope().fontFamily,
    color: color,
  );

  static TextStyle headingTextStyle({
    required Color? color,
    required double? fontSize,
    double? letterSpacing,
    double? height,
  }) => TextStyle(
    letterSpacing: letterSpacing,
    height: height,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.gildaDisplay().fontFamily,
    wordSpacing: 0,
    color: color,
  );

  static TextStyle contentTextStyle({
    required Color? color,
    double? fontSize,
  }) => TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.manrope().fontFamily,
    color: color,
  );

  static TextStyle buttonTextStyle({required Color? color}) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.manrope().fontFamily,
    color: color,
  );

  static TextStyle containerTextStyle({
    required Color? color,
    required double? fontSize,
  }) => TextStyle(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: color,
  );
  static TextStyle container1TextStyle({required Color? color}) => TextStyle(
    fontFamily: GoogleFonts.manrope().fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: color,
  );
  static TextStyle serviceTitleTextStyle({required Color? color}) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.manrope().fontFamily,
    color: color,
  );
  static TextStyle serviceSubTitleTextStyle({required Color? color}) =>
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.manrope().fontFamily,
        color: color,
      );
  static TextStyle communityTextStyle({
    required Color? color,
    required double? fontSize,
    double? letterSpacing,
    double? height,
  }) => TextStyle(
    letterSpacing: letterSpacing,
    fontSize: fontSize,
    height: height,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.gildaDisplay().fontFamily,
    color: color,
  );

  static TextStyle communityTextTextStyle({
    required Color? color,
    required double? fontSize,
  }) => TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.manrope().fontFamily,
    color: color,
  );
  static TextStyle contactTextStyle({
    required Color? color,
    required double? fontSize,
  }) => TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.manrope().fontFamily,
    color: color,
  );
  static TextStyle contactDetailsTextStyle({
    required Color? color,
    required double? fontSize,
  }) => TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.manrope().fontFamily,
    color: color,
  );
}
