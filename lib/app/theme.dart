import 'package:flutter/material.dart';

import 'feature/utils/app_color.dart';
import 'feature/utils/app_text.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData theme01 = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.instance.colorWhite,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.instance.colorPrimary,
      primary: AppColors.instance.colorPrimary,
      secondary: AppColors.instance.colorSecundary,
      background: AppColors.instance.colorWhite,
      onBackground: AppColors.instance.colorWhite,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.instance.colorPrimary,
        foregroundColor: AppColors.instance.colorWhite,
        textStyle: AppTextStyle.instance.aleo20Bold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
      ),
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   fillColor: AppColors.instance.colorWhite,
    //   filled: true,
    //   border: _defaultInputBorder,
    //   enabledBorder: _defaultInputBorder,
    //   focusedBorder: _defaultInputBorder,
    // ),
  );
  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(color: Colors.yellow),
    // borderSide: BorderSide(color: Colors.grey[400]!),
  );
}
