import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
const List<String> fontNames=["taha","janna","jameel"];

class AppTexeStyle {
  static const String fontFamily="jameel";
  static TextStyle get heading => const TextStyle(
        color: Colors.black,
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.bold,
  );

  static TextStyle get subheading => const TextStyle(
        color: Colors.grey,
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.normal
      );
  static   TextStyle get  title => const TextStyle(
        color: Colors.black,
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.bold,
  );

  static TextStyle get subtitle => const TextStyle(
        color: Colors.grey,
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.normal
      );
  static TextStyle get body=> const TextStyle(
        color: Colors.black,
        fontFamily: fontFamily,
        fontSize: 14,
      );
}

class GoogleAppTexeStyle{
  static TextStyle get heading {
    return GoogleFonts.tajawal(
      textStyle: const TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ));
  }
  static TextStyle get subheading {
    return GoogleFonts.tajawal(
        textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.grey,
      fontWeight: FontWeight.bold,
    ));
  }
  static TextStyle get title {
    return GoogleFonts.tajawal(
        textStyle: const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ));
  }
  static TextStyle get subtitle {
    return GoogleFonts.tajawal(
        textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    ));
  }

  static TextStyle get body {
    return GoogleFonts.tajawal(
        textStyle: const TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ));
  }
  static TextStyle get subbody {
    return GoogleFonts.tajawal(
        textStyle: const TextStyle(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ));
  }

}
