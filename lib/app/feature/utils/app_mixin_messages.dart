import 'package:flutter/material.dart';

mixin Messages {
  void showMessageError(BuildContext context, String msg) {
    _showSnackBar(context, msg, Colors.red);
  }

  void showMessageInfo(BuildContext context, String msg) {
    _showSnackBar(context, msg, Colors.teal);
  }

  void _showSnackBar(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.all(20),
          backgroundColor: color,
          content: Text(msg),
        ),
      );
  }
}
