import 'package:flutter/material.dart';

extension AppSizeExtensions on BuildContext {
  double get appScreenWidth => MediaQuery.sizeOf(this).width;
  double get appScreenHeight => MediaQuery.sizeOf(this).height;
  double get appScreenShortestSide => MediaQuery.sizeOf(this).shortestSide;
  double get appScreenLongestSide => MediaQuery.sizeOf(this).longestSide;

  double appPercentWidth(double percent) => appScreenWidth * percent / 100;
  double appPercentHeight(double percent) => appScreenHeight * percent / 100;
}
