import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin Loader {
  var isOpen = false;
  void showLoader(BuildContext context) async {
    if (!isOpen) {
      isOpen = true;
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
  }

  void hideLoader(BuildContext context) {
    if (isOpen) {
      isOpen = false;
      context.pop();
    }
  }
}
