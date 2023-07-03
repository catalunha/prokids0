import 'package:flutter/material.dart';

class AppColors {
  static AppColors? _instance;
  // Avoid self isntance
  AppColors._();
  static AppColors get instance {
    _instance ??= AppColors._();
    return _instance!;
  }

  Color get colorWhite => const Color(0XFFFFFFFF);
  Color get colorBlack => const Color(0XFF000000);
  Color get colorPrimary => const Color(0XFFFF530A);
  Color get colorSecundary => const Color(0XFFFFE4E3);
  Color get color1 => const Color(0XFF04AD48);
  Color get color2 => const Color(0XFF2422AF);
  Color get color3 => const Color(0XFFFFCAC9);
}

// extension AppColorExtensions on BuildContext {
//   AppColors get appColors => AppColors.instance;
// }
