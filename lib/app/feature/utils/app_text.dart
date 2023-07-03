import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTextStyle {
  static AppTextStyle? _instance;
  AppTextStyle._();
  static AppTextStyle get instance {
    _instance ??= AppTextStyle._();
    return _instance!;
  }

  TextStyle get aleo18Regular => GoogleFonts.aleo(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );
  TextStyle get aleo18Bold => GoogleFonts.aleo(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
  TextStyle get aleo20Bold => GoogleFonts.aleo(
        color: AppColors.instance.colorBlack,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
  TextStyle get acme20Bold => GoogleFonts.acme(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
}
