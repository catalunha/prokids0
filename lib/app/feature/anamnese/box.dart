import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  const Box(
    this.width,
    this.height,
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}
